#!/bin/sh
MINIO_DEFAULT_BUCKETS=${MINIO_DEFAULT_BUCKETS:-"default"}
echo "@ is" "$@"
echo "$@"
/usr/bin/docker-entrypoint.sh "$@" > /dev/stdout &
pid=${!}

# 为local设置权限
mc config host add local http://localhost:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD} --api s3v4
mc ls local/"${MINIO_DEFAULT_BUCKETS}" &> /dev/null
if [ $? -eq 0 ] ; then
  echo "Bucket '${MINIO_DEFAULT_BUCKETS}' already exists. Skip create it."
else
  # 如果桶不存在，则创建名为 hive 的桶
  mc mb local/"${MINIO_DEFAULT_BUCKETS}"
  echo "Bucket '${MINIO_DEFAULT_BUCKETS}' created."
fi

# trap和常驻处理逻辑
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -15 "$pid"
    # wait是用来阻塞当前进程的执行，直至指定的子进程执行结束后，才继续执行
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}
trap 'kill ${!};term_handler' TERM
while true 
do
  tail -f /dev/null & wait ${!} # 这一段是让本sh不退出，并且trap是等到当前没有任务后才处理，因为是wait状态所以可以直接处理
done



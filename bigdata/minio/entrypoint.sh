#!/bin/sh

MINIO_DEFAULT_BUCKETS=${MINIO_DEFAULT_BUCKETS:-"default"}
echo "@ is" "$@"
echo "$@"
/usr/bin/docker-entrypoint.sh "$@" > /dev/stdout &

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
tail -f /dev/null


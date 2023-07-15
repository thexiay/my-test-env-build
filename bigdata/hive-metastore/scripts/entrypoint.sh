#!/bin/sh
export JAVA_HOME="${JAVA_HOME:?"JAVA_HOME has not been initialized!"}"
export HADOOP_HOME="${HADOOP_HOME:?"HADOOP_HOME has not been initizlized!"}"
export HIVE_HOME="${HIVE_HOME:?"HIVE_HOME has not been initizlized!"}"
AWS_JAR="$(find "${HADOOP_HOME}" -name "aws-java-sdk-bundle-*"):$(find "${HADOOP_HOME}" -name "hadoop-aws-*")"
export HADOOP_CLASSPATH="$("${HADOOP_HOME}"/bin/hadoop classpath):${AWS_JAR}"

# Check if schema exists
"${HIVE_HOME}"/bin/schematool -dbType mysql -info

if [ $? -eq 1 ]; then
  echo "Getting schema info failed. Probably not initialized. Initializing..."
  "${HIVE_HOME}"/bin/schematool -initSchema -dbType mysql
fi

"${HIVE_HOME}"/bin/start-metastore &
pid=${!}

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
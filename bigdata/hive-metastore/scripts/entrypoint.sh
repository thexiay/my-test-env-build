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

"${HIVE_HOME}"/bin/start-metastore
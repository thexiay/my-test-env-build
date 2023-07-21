FROM ubuntu:22.10 as builder
WORKDIR /opt/spark
# hadoop-aws依赖hadoop-common
RUN apt-get update && apt-get install --assume-yes wget && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.1/hadoop-common-3.3.1.jar && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar && \
    wget https://search.maven.org/remotecontent?filepath=org/apache/iceberg/iceberg-spark-runtime-3.2_2.12/1.3.0/iceberg-spark-runtime-3.2_2.12-1.3.0.jar -O iceberg-spark-runtime-3.2_2.12-1.3.0.jar 


FROM apache/spark:v3.2.4
ENV PATH="${PATH}:${SPARK_HOME}/bin"
COPY --from=builder /opt/spark/* ${SPARK_HOME}/jars/

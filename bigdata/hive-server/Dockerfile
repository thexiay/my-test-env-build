FROM ubuntu:22.10 as builder
WORKDIR /opt/hive
RUN apt-get update && apt-get install  -y wget && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.271/aws-java-sdk-bundle-1.11.271.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.10.1/hadoop-aws-2.10.1.jar && \
    wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-hive-runtime/1.3.0/iceberg-hive-runtime-1.3.0.jar

FROM apache/hive:3.1.3 as runner
USER root
RUN mkdir /home/hive && \
    chown hive:hive /home/hive
USER hive
COPY --from=builder /opt/hive/* ${HIVE_HOME}/lib/
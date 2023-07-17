FROM ubuntu:22.10 as builder
WORKDIR /opt/hive
RUN apt-get update && apt-get install --assume-yes wget && \
    wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-hive-metastore/1.3.0/iceberg-hive-metastore-1.3.0.jar && \
    wget -O- https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar zxf -

FROM apache/hive:3.1.3 as runner
COPY --from=builder /opt/hive/*.jar /opt/hive/mysql-connector-java-8.0.19/*.jar ${HIVE_HOME}/lib/
COPY scripts/entrypoint.sh /opt/entrypoint.sh
USER root
RUN cp ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-* ${HIVE_HOME}/lib/ && \
    cp ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-* ${HIVE_HOME}/lib/ && \
    chmod +x /opt/entrypoint.sh
USER hive
ENTRYPOINT ["/opt/entrypoint.sh"]
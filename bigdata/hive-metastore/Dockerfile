FROM openjdk:8u342-jre

RUN apt-get update \
 && apt-get install --assume-yes telnet \
 && apt-get clean

WORKDIR /opt

ENV HADOOP_VERSION=2.10.1
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/hive

# 删除log4j是为了防止加载错误的log4j，hive-meatastore日志不好排查了
RUN wget -O- https://repo1.maven.org/maven2/org/apache/hive/hive-standalone-metastore/3.1.2/hive-standalone-metastore-3.1.2-bin.tar.gz | tar zxf - && \
    mv /opt/apache-hive-metastore-3.1.2-bin /opt/hive && \
    wget -O- https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz | tar zxf - && \
    rm -f /opt/hadoop-2.10.1/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar && \
    wget -O- https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar zxf - && \
    cp mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar /opt/hive/lib/ && \
    rm -rf  mysql-connector-java-8.0.19

COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]
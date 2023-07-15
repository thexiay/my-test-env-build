FROM apache/hive:3.1.3

USER root
WORKDIR ${HIVE_HOME}/lib
RUN apt-get update && apt-get install  -y wget && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.271/aws-java-sdk-bundle-1.11.271.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.10.1/hadoop-aws-2.10.1.jar && \
    mkdir /home/hive && \
    chown hive:hive /home/hive

WORKDIR -
USER hive
minio的image说明文档：https://hub.docker.com/r/minio/minio

hive的image说明文档：https://hub.docker.com/r/apache/hive

mc的命令说明：https://min.io/docs/minio/linux/reference/minio-mc.html

如果要启动hive的beeline查询，则启动命令行

```
docker exec -it bigdata-hive-server-1 beeline -u 'jdbc:hive2://localhost:10000/'
```

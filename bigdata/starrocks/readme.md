```sql
# 进入docker容器
docker exec -it xxxx bash
# 快速连接starrocks集群
mysql -P9030 -h127.0.0.1 -uroot --prompt="StarRocks > "
# 创建iceberg catalog，配置元数据相关配置，并且配置s3存储相关的认证
CREATE EXTERNAL CATALOG ice
PROPERTIES
(
    "type" = "iceberg",
    "iceberg.catalog.type" = "hive",
    "hive.metastore.uris" = "thrift://172.17.0.1:9083",
    "aws.s3.enable_ssl" = "true",
    "aws.s3.enable_path_style_access" = "true",
    "aws.s3.endpoint" = "http://172.17.0.1:9000",
    "aws.s3.access_key" = "accesskey",
    "aws.s3.secret_key" = "secretkey"
);

# 设置默认的catalog
set catalog ice;
```

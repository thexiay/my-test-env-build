
```shell

#  编译镜像
docker build -t  thexia/spark:v3.2.4 .
# 执行spark-sql，注意要配置iceberg catalog，要配置s3的路径
docker run -it --rm thexia/spark:v3.2.4 spark-sql \
    --conf spark.sql.defaultCatalog=hive_prod \
    --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
    --conf spark.sql.catalog.spark_catalog=org.apache.iceberg.spark.SparkSessionCatalog \
    --conf spark.sql.catalog.spark_catalog.type=hive \
    --conf spark.sql.catalog.hive_prod=org.apache.iceberg.spark.SparkCatalog \
    --conf spark.sql.catalog.hive_prod.type=hive \
    --conf spark.sql.catalog.hive_prod.uri=thrift://172.17.0.1:9083 \
    --conf spark.hadoop.fs.s3a.access.key=accesskey \
    --conf spark.hadoop.fs.s3a.secret.key=secretkey \
    --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem \
    --conf spark.hadoop.fs.s3a.endpoint=http://172.17.0.1:9000 \
    --conf spark.hadoop.fs.s3a.path.style.access=true
```



    `<property>`

    `<name>`fs.s3a.impl`</name>`

    `<value>`org.apache.hadoop.fs.s3a.S3AFileSystem`</value>`

    `</property>`

    `<property>`

    `<name>`fs.s3a.access.key`</name>`

    `<value>`accesskey`</value>`

    `</property>`

    `<property>`

    `<name>`fs.s3a.secret.key`</name>`

    `<value>`secretkey`</value>`

    `</property>`

    `<property>`

    `<name>`fs.s3a.endpoint`</name>`

    `<value>`http://minio:9000`</value>`

    `</property>`

    `<property>`

    `<name>`fs.s3a.path.style.access`</name>`

    `<value>`true`</value>`

    `</property>`

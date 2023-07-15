FROM quay.io/minio/minio:RELEASE.2023-07-11T21-29-34Z

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chmod +x /opt/bin/mc
# 这里是sh和直接调用shell 区别巨大
ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["minio"]
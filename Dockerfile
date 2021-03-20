FROM alpine:latest


COPY etcd /usr/local/bin/
COPY etcdctl /usr/local/bin/
COPY entrypoint.sh /

RUN mkdir -p /var/etcd/data/ \
	&& chmod +x /usr/local/bin/etcd \
	&& chmod +x /usr/local/bin/etcdctl \
	&& chmod +x /entrypoint.sh \
	&& chmod 0700 /var/etcd/data/

EXPOSE 2379 2380
ENV ETCD_DATA_DIR /var/etcd/data/
ENV ETCD_HOST 127.0.0.1
ENTRYPOINT ["/entrypoint.sh"]
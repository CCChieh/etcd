FROM alpine:latest


COPY etcd /usr/local/bin/
COPY etcdctl /usr/local/bin/

RUN mkdir -p /var/etcd/data/ \
	&& chmod +x etcd /usr/local/bin/etcd \
	&& chmod +x etcd /usr/local/bin/etcdctl

EXPOSE 2379 2380
ENV ETCD_DATA_DIR /var/etcd/data/
ENTRYPOINT ["/usr/local/bin/etcd"]
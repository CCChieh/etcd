# Etcd Docker

假设本机的ip为192.168.1.5

启动etcd：

```bash
docker run -itd -p 2379:2379 -p 2380:2380 etcd \
--name n1 \
--initial-advertise-peer-urls http://192.168.1.5:2380 \
--listen-peer-urls http://0.0.0.0:2380 \
--advertise-client-urls http://192.168.1.5:2379 \
--listen-client-urls http://0.0.0.0:2379 \
--initial-cluster n1=http://192.168.1.5:2380 \
--initial-cluster-state new \
--initial-cluster-token etcd-test-cluster
```


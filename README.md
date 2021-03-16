# Etcd Docker

假设本机的ip为192.168.0.115

启动etcd：

```bash
export LOCAL_IP=192.168.0.115
mkdir /root/etcd
chmod -R 700 /root/etcd
docker run -itd -p 2379:2379 -p 2380:2380 -v /root/etcd/:/var/etcd/data/ --restart=always --name=etcd ccchieh/etcd \
--name n0 \
--initial-advertise-peer-urls http://${LOCAL_IP}:2380 \
--listen-peer-urls http://0.0.0.0:2380 \
--advertise-client-urls http://${LOCAL_IP}:2379 \
--listen-client-urls http://0.0.0.0:2379 \
--initial-cluster n0=http://${LOCAL_IP}:2380 \
--initial-cluster-state new \
--initial-cluster-token workshop
```

cannot access data directory: directory "/var/etcd/data/","drwxr-xr-x" exist without desired file permission "-rwx------".

则需要修改权限：

chmod -R 700 /root/etcd

etcd-v3.3.24

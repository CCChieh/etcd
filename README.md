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

## 添加新的机器

n0 上执行

docker exec -it etcd etcdctl member add n1 http://192.168.0.116:2380

另一台机器执行

```bash
export LOCAL_IP=192.168.0.116
mkdir /root/etcd
chmod -R 700 /root/etcd
docker run -itd -p 2379:2379 -p 2380:2380 -v /root/etcd/:/var/etcd/data/ --restart=always --name=etcd ccchieh/etcd \
--name n1 \
--initial-advertise-peer-urls http://${LOCAL_IP}:2380 \
--listen-peer-urls http://0.0.0.0:2380 \
--advertise-client-urls http://${LOCAL_IP}:2379 \
--listen-client-urls http://0.0.0.0:2379 \
--initial-cluster n0=http://192.168.0.115:2380,n1=http://192.168.0.116:2380 \
--initial-cluster-state existing \
--initial-cluster-token workshop
```

## 停止

docker stop etcd && docker rm etcd && rm -rf /root/etcd/

etcd-v3.3.24

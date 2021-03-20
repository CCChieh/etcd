# Etcd Docker

假设本机的ip为192.168.0.115

启动etcd：

```shell
docker run -itd -p 2379:2379 -p 2380:2380 -v /root/etcd/:/var/etcd/data/ \
-e ETCD_HOST=172.19.245.253 \
-e ETCD_NAME=etcd1 \
-e ETCD_INITIAL_CLUSTER_STATE=new \
-e ETCD_INITIAL_CLUSTER_token=clusterToken \
-e ETCD_INITIAL_CLUSTER="etcd1=http://172.19.245.253:2380" \
--restart=always --name=etcd ccchieh/etcd
```

或

```bash
export ETCD_HOST=192.168.0.115
mkdir /root/etcd
docker run -itd -p 2379:2379 -p 2380:2380 -v /root/etcd/:/var/etcd/data/ \
-e ETCD_HOST=${ETCD_HOST} \
-e ETCD_NAME=etcd1 \
-e ETCD_INITIAL_CLUSTER_STATE=new \
-e ETCD_INITIAL_CLUSTER_token=clusterToken \
-e ETCD_INITIAL_CLUSTER="etcd1=http://${ETCD_HOST}:2380" \
--restart=always --name=etcd ccchieh/etcd
```

cannot access data directory: directory "/var/etcd/data/","drwxr-xr-x" exist without desired file permission "-rwx------".

则需要修改权限：

chmod -R 700 /root/etcd

## 添加新的机器

etcd1 上执行

`docker exec -it etcd etcdctl member add etcd2 http://192.168.0.116:2380`

另一台机器执行

```bash
export ETCD_HOST=192.168.0.116
mkdir /root/etcd
docker run -itd -p 2379:2379 -p 2380:2380 -v /root/etcd/:/var/etcd/data/ \
-e ETCD_HOST=${ETCD_HOST} \
-e ETCD_NAME=etcd2 \
-e ETCD_INITIAL_CLUSTER_STATE=existing \
-e ETCD_INITIAL_CLUSTER_token=clusterToken \
-e ETCD_INITIAL_CLUSTER="n0=http://192.168.0.115:2380,n1=http://192.168.0.116:2380" \
--restart=always --name=etcd ccchieh/etcd
```

## 相关命令
1. 停止`docker stop etcd && docker rm etcd && rm -rf /root/etcd/`
2. 查看集群列表`docker exec -it etcd etcdctl list`


etcd-v3.3.24

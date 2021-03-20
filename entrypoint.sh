#!/bin/sh

chmod -R 700 ${ETCD_DATA_DIR}

/usr/local/bin/etcd \
--initial-advertise-peer-urls http://${ETCD_HOST}:2380 \
--listen-peer-urls http://0.0.0.0:2380 \
--advertise-client-urls http://${ETCD_HOST}:2379 \
--listen-client-urls http://0.0.0.0:2379
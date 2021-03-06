#!/bin/bash

set -e

./use_aliyun_kubernetes_yum_source.sh

# setenforce 0
str1=`/usr/sbin/sestatus -v`
str2=disabled
if [ ${str1##* } = $str2 ]
then echo SElinux had was disabled
else setenforce 0
fi
# Use Kubernetes-cni-0.6.0 explictly
# https://github.com/kubernetes/kubernetes/issues/75701
yum install -y kubelet-1.17.4 kubeadm-1.17.4 kubectl-1.17.4 --disableexcludes=kubernetes

# Check installed Kubernetes packages
yum list installed | grep kube

systemctl enable kubelet && systemctl start kubelet

systemctl daemon-reload
systemctl restart kubelet

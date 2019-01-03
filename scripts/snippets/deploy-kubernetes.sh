#!/bin/bash
set -ex

mkdir -p /etc/kubernetes/kubeadm
tee /etc/kubernetes/kubeadm/create.yaml <<EOF
apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
clusterName: kubernetes
kubernetesVersion: v1.13.1
imageRepository: k8s.gcr.io
networking:
  dnsDomain: cluster.local
  podSubnet: 172.18.0.0/16
  serviceSubnet: 10.96.0.0/12
---
apiVersion: kubeadm.k8s.io/v1alpha3
kind: InitConfiguration
bootstrapTokens:
  - groups:
      - system:bootstrappers:kubeadm:default-node-token
    token: tkuplq.civsgihd1s6cg94e
    ttl: 24h0m0s
    usages:
      - signing
      - authentication
---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: ipvs
EOF

kubeadm config images pull --config /etc/kubernetes/kubeadm/create.yaml
docker images

kubeadm init --config /etc/kubernetes/kubeadm/create.yaml --ignore-preflight-errors RequiredIPVSKernelModulesAvailable

mkdir -p "$HOME/.kube"
cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
chown "$(id -u):$(id -g)" "$HOME/.kube/config"

kubectl taint nodes --all node-role.kubernetes.io/master-

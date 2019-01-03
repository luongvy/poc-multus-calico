#!/bin/bash
set -ex

kubectl wait --timeout=120s --for=condition=Ready nodes/$(hostname)

until kubectl get pods -n kube-system -l k8s-app=kube-dns --no-headers -o name | grep -q "^pod/coredns"; do
  sleep 5
done
kubectl wait --timeout=480s --for=condition=Ready pods -n kube-system -l k8s-app=kube-dns

kubectl get --all-namespaces pods -o wide

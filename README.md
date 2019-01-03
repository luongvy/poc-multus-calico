# poc-multus-calico

This is a simple vagrant deployment of kubeadm, using multus as the cni.

The intent is to use this repo to develop example manifests for multis with calico
operation.

There is an Environment variable on line 22 of the vragrant file, that allows you
to select which set of cni manifests to deploy from the `/manifests/` directory.

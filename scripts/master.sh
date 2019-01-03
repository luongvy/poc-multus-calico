#!/bin/bash
set -ex

bash ./scripts/snippets/install-docker.sh
bash ./scripts/snippets/install-cni.sh
bash ./scripts/snippets/install-kubernetes.sh
bash ./scripts/snippets/deploy-kubernetes.sh
bash ./scripts/snippets/deploy-cni.sh
bash ./scripts/snippets/wait-for-k8s.sh

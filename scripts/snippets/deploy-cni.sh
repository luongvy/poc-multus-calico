#!/bin/bash
set -ex


kubectl apply -f ./manifests/${DEFAULT_CNI}

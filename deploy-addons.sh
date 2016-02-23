#!/bin/bash

# Copyright 2015 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Deploy the addon services after the cluster is available
# TODO: integrate with or use /cluster/saltbase/salt/kube-addons/kube-addons.sh
# Requires:
#   ENABLE_CLUSTER_DNS (Optional) - 'Y' to deploy kube-dns
#   KUBE_SERVER (Optional) - url to the api server for configuring kube-dns

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

ENABLE_CLUSTER_DNS=true
DNS_SERVER_IP="10.0.0.10"
DNS_DOMAIN="cluster.local"
DNS_REPLICAS=1
ENABLE_CLUSTER_UI=true
ENABLE_DM=true

KUBE_ROOT="https://raw.githubusercontent.com/kubernetes/kubernetes/master"
bin="$(cd "$(dirname "${BASH_SOURCE}")" && pwd -P)"

# create the kube-system
kubectl create -f "${KUBE_ROOT}/cluster/mesos/docker/kube-system-ns.yaml"

# grab intemp from github
curl -o- https://raw.githubusercontent.com/karlkfi/intemp/master/install.sh | bash

if [ "${ENABLE_CLUSTER_DNS}" == "true" ]; then
  echo "Deploying DNS Addon" 1>&2
  "${bin}/intemp.sh" -t 'kube-dns' "${bin}/deploy-dns.sh"
fi

if [ "${ENABLE_CLUSTER_UI}" == "true" ]; then
  echo "Deploying UI Addon" 1>&2
  "${bin}/deploy-ui.sh"
fi

if [ "${ENABLE_DM}" == "true" ]; then
  echo "Deploying DM" 1>&2
  curl -s https://raw.githubusercontent.com/kubernetes/deployment-manager/master/get-install.sh | sh
fi


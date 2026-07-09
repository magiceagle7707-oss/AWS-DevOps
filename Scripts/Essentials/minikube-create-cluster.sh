#!/bin/bash

set -euo pipefail

echo "**********************************************************************"
echo "        Starting Minikube cluster creation"
echo "**********************************************************************"

minikube start --driver=docker

echo
echo "!...Verifying Minikube cluster status...!"
echo

kubectl get nodes

echo
echo "!...Cluster Information...!"
echo

kubectl cluster-info

echo
echo "**********************************************************************"
echo "        Minikube cluster created successfully!"
echo "**********************************************************************"
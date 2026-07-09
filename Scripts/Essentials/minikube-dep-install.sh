#!/bin/bash

# Creation of a Minikube cluster on a fresh Amazon Linux EC2 instance

set -euo pipefail

echo "**********************************************************************"
echo "        Starting minikube cluster creation on AWS EC2 instance"
echo "**********************************************************************"

sudo yum update -y

echo "**********************************************************************"
echo "        Installing dependencies for minikube ~ Docker"
echo "**********************************************************************"

sudo yum install -y docker

echo " "
echo "!...Starting Docker service...!"
echo " "

sudo systemctl start docker
sudo systemctl enable docker

echo "**********************************************************************"
echo "        Docker is UP and running"
echo "**********************************************************************"

echo " "
echo "!...Giving permissions to the user to run docker commands without sudo...!"
echo " "

sudo usermod -aG docker $USER

echo " "
echo "!!! You may need to restart your session to apply the changes !!!"
echo " "

echo "**********************************************************************"
echo "        Installing dependencies for minikube ~ curl"
echo "**********************************************************************"

sudo yum install -y curl

# If the script failing at this point, remove the following line and run the script again:
# set -euo pipefail
# this is because AMI already contains curl-minial package, which is not compatible with the script.

echo "**********************************************************************"
echo "        Installing dependencies for minikube ~ kubectl"
echo "**********************************************************************"

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "**********************************************************************"
echo "        Installing dependencies for minikube ~ minikube binaries"
echo "**********************************************************************"

curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

echo " "
echo "!...Verifying installation...!"
echo " "

docker --version
kubectl version --client
minikube version

echo "======================================================"
echo "Installation completed."
echo
echo "Please log out and reconnect via SSH."
echo "Then run:"
echo "minikube start --driver=docker"
echo "======================================================"




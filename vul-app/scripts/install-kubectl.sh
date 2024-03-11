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
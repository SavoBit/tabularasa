#! /bin/bash

# Install docker
apt-get update
apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get -y install docker-ce

# add aporeto user to docker group
usermod aporeto -aG docker

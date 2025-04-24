#!/bin/bash

# Homework 1 - Docker Core Concepts

# Exercise 1
# 1
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 2
sudo systemctl enable docker
sudo systemctl start docker

# 3
sudo usermod -aG docker $USER
docker info

# Exercise 2
# 1
docker search --filter is-official=true ubuntu
docker search --filter is-official=true alpine
docker search --filter is-official=true nginx

# 2
docker run nginx

# Exercise 3
# 1
systemctl status docker

# 2
sudo systemctl stop docker.service
sudo systemctl stop docker.socket
systemctl status docker

# 3
run docker nginx

# 4
sudo systemctl restart docker
run docker nginx

# Exercise 4
# 1
docker run -it ubuntu

# 2
apt update && apt install curl

# 3
exit

# Exercise 5
# 1
docker ps

# 2
docker ps -a

# Exercise 6
# 1
docker run -d --name test nginx
docker ps

# 2
docker pause test
docker ps

# 3 
docker unpause test
docker ps

# 4
docker stop test
docker ps

# 5
docker restart test
docker ps

# 6
docker kill test
docker ps

# Exercise 7
# 1
docker run -d --name test nginx
docker ps
docker rm -f test
docker ps

# Exercise 8
# 1
docker pull alpine
docker pull 

# 2
docker images ls

# Exercise 9
# 1
docker run --name test-alpine alpine echo "hello from alpine"

# 2
docker run --name test-busybox busybox uname -a 

# 3
docker ps -a

# Exercise 10
# 1
docker container prune -f
docker ps -a

# 2
docker image prune -a -f
docker image ls

# 3
docker system df
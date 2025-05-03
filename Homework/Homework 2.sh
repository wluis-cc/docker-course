#!/bin/bash

# Homework 2 - Docker Extended Topics
# These exercises focus on Docker networking, volumes, bind mounts, Docker-in-Docker, resource limits, and restart policies.

# Exercise 1 

# 1. List all Docker networks. 
docker network ls
# 2. Inspect the default bridge network. 
docker network inspect bridge
# 3. Create a new bridge user-defined network. 
docker network create dockernet
# 4. Run a container attached to it and inspect its IP. 
docker run -d --name webserver --network dockernet nginx
docker inspect webserver | grep IPAddress


# Exercise 2 

# 1. Run two Nginx containers which have to be connected to that user-defined network created in Exercise 1.
docker run -d --name webserver2 --network dockernet nginx 

# 2. Use ping within both containers to test communication each other by container name. 
docker exec -it webserver bash
ping webserver2
docker exec -it webserver2 bash
ping webserver


# Exercise 3 

# 1. Create a Docker volume: mydata . 
docker volume create mydata
docker volume ls

# 2. Run a container using the volume. 
docker run -d --name files -v mydata:/data nginx

# 3. Write a file inside /data from the container, then: 
docker exec -it files bash
ls
cd cada
touch data.txt
ls

# 3.1. Stop the container. 
exit
docker stop files
docker ps

# 3.2. Relaunch to verify persistence 
docker start files
docker exec -it files bash
ls
cd data
ls


# Exercise 4 

# 1. Create a directory on your host. 
mkdir hostdir
# 2. Run a container with a bind mount. 
docker run -d --name bindmount -v $(pwd)/hostdir:/mnt nginx
# 3. Create a file in /mnt from the container and check the host. 
docker exec -it bindmount bash
cd /mnt
touch data.txt
ls
exit
cd $(pwd)/hostdir
ls


# Exercise 5 

# 1. Create a file in a named volume. 
docker exec -it files bash
ls
cd /data
ls
touch flesvolume.txt
ls
exit

# 2. Create a file using a bind mount. 
cd hostdir
sudo touch findfile.txt
ls
# 3. Observe where data is stored on the host with docker volume inspect and ls . 
docker volume inspect mydata
sudo ls /var/lib/docker/volumes/mydata/_data
 

# Exercise 6 

# 1. Run an Ubuntu container with the necessary options to enable Docker in Docker (DinD). 
docker run -d --name dind --privileged -v /var/run/docker.sock:/var/run/docker.sock docker:dind
docker ps
docker exec -it dind bash
# 2. Exec into the container and run docker version . 


# Exercise 7 

# 1. Run a container with memory and CPU limits: Memory = 256m CPU = 0.5 
docker run -d --name limited --memory=256m --cpus=0.5 nginx
# 2. Check resource usage stats . 
docker stats limited
# 3. Check disk usage (docker system). 
docker system df
 

# Exercise 8 

# 1. Run a container with policy --restart on-failure . 
# 2. Kill the container and observe how it restarts 
docker run -d --name failtest --restart on-failure alpine sh -c "exit 1"
# 3. Try with the policy --restart unless-stopped 
# 4. Reboot the system and see what happens. 
docker run -d --name failtest2 --restart unless-stopped alpine
watch docker ps


# Exercise 9 

# 1. Create a network dbnet . 
docker network create dbnet
# 2. Create a volume dbdata . 
docker volume create dbdata
# 3. Run a MariaDB container with the following requirements: 1. Attached to volume dbdata 2. Attached to network dbnet 3. Do NOT expose ANY port. 
docker run -d --name mariadb --network dbnet -v dbdata:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=secret -e MARIADB_DATABASE=mydatabase -e MARIADB_USER=myuser -e MARIADB_PASSWORD=mypassword mariadb 


# Exercise 10 

# 1. Run a PHPMyAdmin container with the following requirements:
# 1.1. Attached to network dbnet (created in Exercise 9). 
# 1.2. Use a bind mount to persist the web app configuration. 
# 1.3. Linked to the previous MariaDB container (created in Exercise 9) 
# 1.4. Open a browser to display the PHPMyAdmin Login Form.
# 1.5. Login with the DB credentials. 
docker run -d --name phpmyadmin --network dbnet -e PMA_HOST=mariadb -p 8080:80 phpmyadmin/phpmyadmin
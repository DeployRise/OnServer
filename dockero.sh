#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nano -y

# Docker
wget -O- https://raw.githubusercontent.com/DeployRise/OnServer/main/docker-install.sh | sudo /bin/bash
docker network create ljchuello

# Chrony
apt install chrony -y
systemctl enable chrony
systemctl start chrony

# Firewalld
apt install firewalld -y
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-service=ssh
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --permanent --add-port-25565/tcp
firewall-cmd --reload
firewall-cmd --permanent --add-port=81/tcp

# Glances
docker run -d --name glances --restart="always" --network ljchuello -p 85:80 -v /var/run/docker.sock:/var/run/docker.sock:ro -e GLANCES_OPT="-w -p 80" --pid host nicolargo/glances:latest-full

# Nginx Proxy Manager
docker run -d \
 --name nginxproxymanager \
 --restart unless-stopped \
 --network ljchuello \
 -p 80:80 \
 -p 81:81 \
 -p 443:443 \
 -v "/root/nginxproxymanager/data:/data" \
 -v "/root/nginxproxymanager/letsencrypt:/etc/letsencrypt" \
 docker.io/jc21/nginx-proxy-manager:latest

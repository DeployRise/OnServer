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

# Glances
docker run -d --name glances --restart always --pid host --network host -e GLANCES_OPT="-w -p 27017 -t 3" nicolargo/glances:latest-full

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

# Firewall
apt install ufw -y
ufw allow 22/tcp
echo "y" | ufw enable

# Firewall Docker
wget -O /usr/local/bin/ufw-docker https://github.com/chaifeng/ufw-docker/raw/master/ufw-docker
chmod +x /usr/local/bin/ufw-docker
ufw-docker install
ufw-docker allow nginxproxymanager 80/tcp
ufw-docker allow nginxproxymanager 443/tcp
ufw-docker allow nginxproxymanager 81/tcp

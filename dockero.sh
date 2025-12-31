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

# Chrony
apt install chrony -y
systemctl enable chrony
systemctl start chrony

# Glances Service
docker run -d --name glances --restart always --pid host --network host -e GLANCES_OPT="-w -p 27017 -t 3" nicolargo/glances:latest-full

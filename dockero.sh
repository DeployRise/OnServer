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

# Firewall
apt install ufw -y
echo "y" | ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
dotnet dev-certs https

# Glances
docker run -d --name glances --restart="always" --network ljchuello -v /var/run/docker.sock:/var/run/docker.sock:ro -e GLANCES_OPT="-w -p 8085" --pid host nicolargo/glances:latest-full

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

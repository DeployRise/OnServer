#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nginx -y
apt install nano -y
apt install openssl -y

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# NodeJS LTS
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
apt install -y nodejs

# Python 3
apt install python3 -y
apt install python3-dev -y
apt install python3-pip -y
apt install gcc python3-dev -y

# Install Firewall
apt install ufw -y
echo "y" | ufw enable

# Enabling traffic from the internet
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 27017/tcp

# Chrony
apt install chrony -y
systemctl enable chrony
systemctl start chrony

# Glances
pip install glances[all] --break-system-packages

# Glances Service
cd /etc/systemd/system/
wget -O glances.service https://raw.githubusercontent.com/DeployRise/OnServer/main/glances.service
systemctl start glances
systemctl enable glances

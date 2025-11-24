#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
# apt install nginx -y
apt install nano -y
# apt install sed -y
# apt install openssl -y
# wget -O -  https://get.acme.sh | sh -s email=lalo@landa.com

# Firewall
apt install ufw -y
echo "y" | ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 81/tcp
ufw allow 443/tcp

# Docker
wget -O- https://raw.githubusercontent.com/DeployRise/OnServer/main/docker-install.sh | sudo /bin/bash

# Python 3
apt install python3 -y
apt install python3-dev -y
apt install python3-pip -y
apt install gcc python3-dev -y

# Chrony
apt install chrony -y
systemctl enable chrony
systemctl start chrony

# Glances Service
# pip install glances[all] --break-system-packages
pip install glances[all] --break-system-packages --ignore-installed --force-reinstall urllib3
wget -O /etc/systemd/system/glances.service https://raw.githubusercontent.com/DeployRise/OnServer/main/glances.service
systemctl start glances
systemctl enable glances

# IPv4 --force
sed -i 's/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/' /etc/gai.conf
systemctl restart networking

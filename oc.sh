#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nano -y

# Firewall
apt install ufw -y
echo "y" | ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

# Chrony
apt install chrony -y
systemctl enable chrony
systemctl start chrony

# Install OC
curl -fsSL https://openclaw.ai/install.sh | bash

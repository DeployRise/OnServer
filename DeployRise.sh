#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nginx -y
apt install nano -y

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Install Firewall
apt install ufw -y
echo "y" | ufw enable

# Enabling traffic from the internet
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 27017/tcp

# Glances
apt install python3
apt install python3-dev -y
apt install python3-pip -y
wget -O- https://raw.githubusercontent.com/nicolargo/glancesautoinstall/master/install.sh | /bin/bash

# Glances Service
cd /etc/systemd/system/
wget -O glances.service https://raw.githubusercontent.com/DeployRise/OnServer/main/glances.service
systemctl start glances
systemctl enable glances

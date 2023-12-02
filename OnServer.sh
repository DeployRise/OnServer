#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nginx -y

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Firewall
apt install ufw -y
echo "y" | ufw enable

# Enabling traffic from the internet
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 27017/tcp

# Enabling traffic from the local network
# ufw allow from 10.0.0.0/8
# ufw allow from 172.16.0.0/12
# ufw allow from 192.168.0.0/16

# Glances
apt install python3
apt install python3-dev -y
apt install python3-pip -y
wget -O- https://raw.githubusercontent.com/nicolargo/glancesautoinstall/master/install.sh | /bin/bash
  
# Glances Service
cd /etc/systemd/system/
wget -O glances-iqx5u.service https://raw.githubusercontent.com/DeployRise/OnServer/main/glances-iqx5u.service
systemctl start glances-iqx5u
systemctl enable glances-iqx5u

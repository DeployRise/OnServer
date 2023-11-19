#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nginx -y
apt install iperf3 -y

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Glances
apt install python3
apt install python3-dev -y
apt install python3-pip -y
wget -O- https://bit.ly/glances | /bin/bash
  
# Glances Service
cd /etc/systemd/system/
wget -O glances-iqx5u.service "https://raw.githubusercontent.com/DeployRise/OnServer/main/glances-iqx5u.service"
systemctl start glances-iqx5u
systemctl enable glances-iqx5u

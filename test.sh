#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nginx -y

# Network
apt install iperf3 -y
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
apt-get install speedtest -y

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

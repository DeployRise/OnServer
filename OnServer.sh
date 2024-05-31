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
wget -O -  https://get.acme.sh | sh -s email=lalo@landa.com

# Firewall
apt install ufw -y
echo "y" | ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 27017/tcp

# Index & Certificates
rm /var/www/html/index.nginx-debian.html
wget -O /var/www/html/index.html https://raw.githubusercontent.com/DeployRise/OnServer/main/tools/index.html
wget -O /etc/ssl/certificate.crt https://raw.githubusercontent.com/DeployRise/OnServer/main/tools/certificate.crt
wget -O /etc/ssl/certificate.key https://raw.githubusercontent.com/DeployRise/OnServer/main/tools/certificate.key

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
dotnet dev-certs https

# NodeJS LTS
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash -
apt install -y nodejs

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
pip install glances[all] --break-system-packages
wget -O /etc/systemd/system/glances.service https://raw.githubusercontent.com/DeployRise/OnServer/main/glances.service
systemctl start glances
systemctl enable glances

# Gossip
HOSTNAME=$(hostname)
IP=$(curl -s https://checkip.amazonaws.com)

# Gossip | Dev
curl --location "https://monitor-certain-blatantly.ngrok-free.app/api/Values?hostname=$HOSTNAME&dirIP=$IP" --header "ngrok-skip-browser-warning: 25628a09-ab5c-44db-8a7d-8727a30ca26e"

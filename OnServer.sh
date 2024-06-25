#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nginx -y
apt install nano -y
apt install sed -y
apt install openssl -y
wget -O -  https://get.acme.sh | sh -s email=lalo@landa.com

# Firewall
apt install ufw -y
echo "y" | ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 27017/tcp
ufw allow 50000:60000

# Index & Certificates
rm /var/www/html/index.nginx-debian.html
wget -O /var/www/html/index.html https://raw.githubusercontent.com/DeployRise/OnServer/main/tools/index.html
sudo openssl genpkey -algorithm RSA -out /etc/ssl/certificate.key -pkeyopt rsa_keygen_bits:2048
sudo openssl req -new -key /etc/ssl/certificate.key -out /etc/ssl/certificate.csr -subj "/CN=ctcs490qf5ob1d6hje.deployrise.com"
sudo openssl x509 -req -days 5475 -in /etc/ssl/certificate.csr -signkey /etc/ssl/certificate.key -out /etc/ssl/certificate.crt

# .NET Core LTS
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
dotnet dev-certs https

# .NET Core
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 8.0 --install-dir /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

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

# IPv4 --force
sed -i 's/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/' /etc/gai.conf
systemctl restart networking

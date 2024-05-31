#!/bin/bash

# Updates the packages
DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Tools
apt install curl -y
apt install wget -y
apt install unzip -y
apt install nginx -y
apt install nano -y

# Chrony
apt install chrony -y
systemctl enable chrony
systemctl start chrony

# Install
curl https://binaries.cockroachdb.com/cockroach-v23.1.14.linux-amd64.tgz | tar -xz && sudo cp -i cockroach-v23.1.14.linux-amd64/cockroach /usr/local/bin/
mkdir -p /usr/local/lib/cockroach
cp -i cockroach-v23.1.14.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/
cp -i cockroach-v23.1.14.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/
which cockroach

# Generate certificates
mkdir certs
mkdir my-safe-directory

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
cd /root/
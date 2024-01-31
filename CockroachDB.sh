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

# Clock
apt install chrony -y
systemctl enable chrony
systemctl start chrony

# Install
curl https://binaries.cockroachdb.com/cockroach-v23.1.14.linux-amd64.tgz | tar -xz && sudo cp -i cockroach-v23.1.14.linux-amd64/cockroach /usr/local/bin/
mkdir -p /usr/local/lib/cockroach
cp -i cockroach-v23.1.14.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/
cp -i cockroach-v23.1.14.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/
which cockroach

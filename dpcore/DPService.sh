#!/bin/bash

# Creamos el directorio
mkdir -p /var/DeployRise/DeployRiseService

# Descargamos
wget -O /var/DeployRise/dpcore.zip https://raw.githubusercontent.com/DeployRise/OnServer/main/dpcore/dpcore.zip

# Extraemos
unzip /var/DeployRise/dpcore.zip -d /var/DeployRise/DeployRiseService

# Eliminamos el .zip
rm /var/DeployRise/dpcore.zip

# Descargamos e iniciamos servicio
wget -O /etc/systemd/system/dpcore.service https://raw.githubusercontent.com/DeployRise/OnServer/main/dpcore/dpcore.service
systemctl start dpcore
systemctl enable dpcore
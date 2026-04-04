#!/bin/bash

# 1. Verificar si el usuario tiene privilegios de root
if [ "$EUID" -ne 0 ]; then 
  echo "Por favor, corre el script usando sudo o como root."
  exit
fi

# 2. Detectar la distribución de Linux
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "No se pudo detectar el sistema operativo."
    exit 1
fi

echo "Detectado: $OS"
echo "Iniciando instalación de Docker..."

# 3. Lógica de instalación por distribución
case $OS in
    ubuntu|debian|raspbian|kali|pop|linuxmint)
        # Usar el script oficial de conveniencia para la familia Debian
        curl -fsSL https://get.docker.com | sh
        ;;
    fedora|centos|rhel|rocky|almalinux|ol|amzn)
        # Usar el script oficial para la familia Red Hat
        curl -fsSL https://get.docker.com | sh
        ;;
    arch|manjaro|endeavouros)
        # Instalación nativa para Arch Linux
        pacman -S --noconfirm docker docker-compose
        ;;
    alpine)
        # Instalación nativa para Alpine
        apk add docker docker-compose
        rc-update add docker default
        service docker start
        ;;
    opensuse*|suse)
        # Instalación para openSUSE
        zypper install -y docker docker-compose
        ;;
    *)
        echo "Distribución no soportada directamente por este script."
        echo "Intentando usar el script oficial de Docker por si acaso..."
        curl -fsSL https://get.docker.com | sh
        ;;
esac

# 4. Post-instalación (Habilitar y arrancar servicio)
echo "Configurando servicios..."
if command -v systemctl >/dev/null; then
    systemctl enable --now docker
elif command -v rc-update >/dev/null; then
    # Para sistemas sin systemd (como Alpine)
    rc-update add docker default
    service docker start
fi

# 5. Agregar usuario actual al grupo docker (opcional pero recomendado)
# Nota: USER_NAME es quien invocó el sudo
USER_NAME=${SUDO_USER:-$USER}
usermod -aG docker $USER_NAME

echo "--------------------------------------------------------"
echo "¡Instalación completada con éxito!"
echo "IMPORTANTE: Reinicia tu sesión para usar docker sin sudo."
echo "Comando de prueba: docker --version"
echo "--------------------------------------------------------"

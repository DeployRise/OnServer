## Install All
```wget -O- https://bit.ly/On-Srv | sudo /bin/bash```

## Install All
```wget -O- https://raw.githubusercontent.com/DeployRise/OnServer/main/OnServer.sh | sudo /bin/bash```

###  Recarga los demonios de systemd
```systemctl daemon-reload```

### Habilita el servicio
```systemctl enable dotnetrun.service```

### Iniciar el servicio inmediatamente
```systemctl start dotnetrun.service```
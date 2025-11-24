## Install All
```wget -O- https://bit.ly/On-Srv | sudo /bin/bash```

### Install Docker
```wget -O- https://raw.githubusercontent.com/DeployRise/OnServer/refs/heads/main/dockero.sh | sudo /bin/bash```

## Install All
```wget -O- https://raw.githubusercontent.com/DeployRise/OnServer/main/OnServer.sh | sudo /bin/bash```

## acme.sh
```acme.sh --issue --nginx --force -d example.com```

```acme.sh --register-account -m lalo@landa.com --server google --eab-kid xxx --eab-hmac-key xxx```

```acme.sh --issue --nginx --force --server google -d example.com```

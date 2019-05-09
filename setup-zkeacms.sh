#!/bin/bash
function isCentos(){
    if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
        return 0
    else
        return 1
    fi
}

function install(){
    isCentos
    if [ $? = 1 ];then
        sudo yum install $1 -y
    else
        sudo apt install $1 -y
    fi
}
function installDotnetCore(){
    isCentos
    if [ $? = 1 ];then
        install icu    
    fi
    install wget
    sudo rm -rf /dotnet 
    sudo mkdir -p /dotnet
    sudo wget -O dotnet.tar.gz http://www.zkea.net/dotnet-runtime-linux
    sudo tar zxf dotnet.tar.gz -C /dotnet
    sudo rm -rf dotnet.tar.gz
}
function installcms(){
    read -p 'Please enter the cms path: ' cmspath
	sudo echo "[Unit]" > /etc/systemd/system/zkeacms.service
	sudo echo "Description=ZKEACMS" >> /etc/systemd/system/zkeacms.service
	sudo echo "[Service]" >> /etc/systemd/system/zkeacms.service
	sudo echo "WorkingDirectory=$cmspath" >> /etc/systemd/system/zkeacms.service
	sudo echo "ExecStart=/dotnet/dotnet $cmspath/ZKEACMS.WebHost.dll" >> /etc/systemd/system/zkeacms.service
	sudo echo "Restart=always" >> /etc/systemd/system/zkeacms.service
	sudo echo "RestartSec=10" >> /etc/systemd/system/zkeacms.service
	sudo echo "SyslogIdentifier=zkeacms" >> /etc/systemd/system/zkeacms.service
	sudo echo "User=root" >> /etc/systemd/system/zkeacms.service
	sudo echo "Environment=ASPNETCORE_ENVIRONMENT=Production" >> /etc/systemd/system/zkeacms.service
	sudo echo "Environment=ASPNETCORE_URLS=http://localhost:5000" >> /etc/systemd/system/zkeacms.service
	sudo echo "[Install]" >> /etc/systemd/system/zkeacms.service
	sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/zkeacms.service
    
    sudo systemctl restart zkeacms
    sudo systemctl enable zkeacms
}

function configNginx(){
    isCentos
    if [ $? = 1 ];then
        sudo rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
    fi
    install nginx
    nginxConfigFile="/etc/nginx/conf.d/default.conf"
    if [[ -d /etc/nginx/sites-available ]]; then
        nginxConfigFile="/etc/nginx/sites-available/default"
    fi
    sudo echo "server {" > $nginxConfigFile
    sudo echo "    listen 80;" >> $nginxConfigFile
    sudo echo "    location / {" >> $nginxConfigFile
    sudo echo "        proxy_pass http://localhost:5000;" >> $nginxConfigFile
    sudo echo "        proxy_http_version 1.1;" >> $nginxConfigFile
    sudo echo "        proxy_set_header Upgrade \$http_upgrade;" >> $nginxConfigFile
    sudo echo "        proxy_set_header Connection keep-alive;" >> $nginxConfigFile
    sudo echo "        proxy_set_header Host \$host;" >> $nginxConfigFile
    sudo echo "        proxy_cache_bypass \$http_upgrade;" >> $nginxConfigFile
    sudo echo "    }" >> $nginxConfigFile
    sudo echo "}" >> $nginxConfigFile
    
    sudo systemctl restart nginx
}
read -p 'Do you want to install nginx?(yes/no) ' installNginx
if [ $installNginx = 'yes' ]; then
    configNginx
fi

installDotnetCore
installcms

#!/bin/bash
function isCentos(){
    if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
        return 0
    else
        return 1
    fi
}
function checkUpdate(){
    isCentos
    if [$? = 1 ];then
        sudo yum check-update -y
    else
        sudo apt update -y
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

    sudo rm -rf /zkeasoft/dotnet 
    sudo mkdir -p /zkeasoft/dotnet
    sudo wget -O dotnet-hosting.tar.gz http://www.zkea.net/dotnet-runtime-linux
    sudo tar zxf dotnet-hosting.tar.gz -C /zkeasoft/dotnet
    sudo rm -rf dotnet-hosting.tar.gz
}
function installcms(){
    sudo rm -rf cms.zip
    sudo wget -O cms.zip http://zkeasoft-10041459.file.myqcloud.com/core/cms.zip
    sudo mkdir -p /zkeasoft/cms
    sudo unzip -q -o cms.zip -d /zkeasoft/cms

	sudo echo [Unit] > /etc/systemd/system/zkeacms.service
	sudo echo Description=ZKEACMS >> /etc/systemd/system/zkeacms.service
	sudo echo [Service] >> /etc/systemd/system/zkeacms.service
	sudo echo WorkingDirectory=/zkeasoft/cms >> /etc/systemd/system/zkeacms.service
	sudo echo ExecStart=/zkeasoft/dotnet/dotnet /zkeasoft/cms/ZKEACMS.WebHost.dll >> /etc/systemd/system/zkeacms.service
	sudo echo Restart=always >> /etc/systemd/system/zkeacms.service
	sudo echo RestartSec=10 >> /etc/systemd/system/zkeacms.service
	sudo echo SyslogIdentifier=zkeacms >> /etc/systemd/system/zkeacms.service
	sudo echo User=root >> /etc/systemd/system/zkeacms.service
	sudo echo Environment=ASPNETCORE_ENVIRONMENT=Production >> /etc/systemd/system/zkeacms.service
	sudo echo Environment=ASPNETCORE_URLS=http://*:80 >> /etc/systemd/system/zkeacms.service
	sudo echo [Install] >> /etc/systemd/system/zkeacms.service
	sudo echo WantedBy=multi-user.target >> /etc/systemd/system/zkeacms.service
    
    sudo systemctl restart zkeacms
    sudo systemctl enable zkeacms
    sudo rm -rf cms.zip
}
checkUpdate
install unzip
installDotnetCore
installcms

#!/bin/sh
function isCentos(){
    if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
        return false
    else
        return true
    fi
}
function checkUpdate(){
    isCentos
    if [$? = true ];then
        sudo yum check-update -y
    else
        sudo apt update -y
    fi
}
function install(){
    isCentos
    if [ $? = true ];then
        sudo yum install $1 -y
    else
        sudo apt install $1 -y
    fi
}
function installDotnetCore(){
    isCentos
    if [ $? = true ];then
        install libunwind
        install libicu
    else
        install libunwind-dev
    fi

    sudo rm -rf /zkeasoft/dotnet 
    sudo mkdir -p /zkeasoft/dotnet
    sudo wget -O dotnet-hosting.tar.gz https://download.microsoft.com/download/1/1/0/11046135-4207-40D3-A795-13ECEA741B32/dotnet-hosting-2.0.5-linux-x64.tar.gz
    sudo tar zxf dotnet-hosting.tar.gz -C /zkeasoft/dotnet
    sudo rm -rf dotnet-hosting.tar.gz
}
function installcms(){
    sudo rm -rf cms.zip
    sudo wget -O cms.zip http://zkeasoft-10041459.file.myqcloud.com/core/cms.zip
    sudo mkdir -p /zkeasoft/cms
    sudo unzip -q -o cms.zip -d /zkeasoft/cms
    sudo wget http://cdn.zkeasoft.com/core/zkeacms.service
    sudo mv zkeacms.service /etc/systemd/system/zkeacms.service -f
    sudo systemctl restart zkeacms
    sudo systemctl enable zkeacms
    sudo rm -rf cms.zip
}
checkUpdate
install unzip
installDotnetCore
installcms
#!/bin/bash2

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg &&
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list' &&
sudo apt-get update -y &&
sudo apt-get install dotnet-sdk-2.0.0 -y &&
sudo apt-get install zip unzip -y &&
sudo apt-get install nginx -y &&
sudo wget -O cms.zip http://cdn.zkeasoft.com/core/cms.zip &&
sudo mkdir /zkeasoft &&
sudo mkdir /zkeasoft/cms &&
sudo unzip cms.zip -d /zkeasoft/cms &&
sudo wget http://cdn.zkeasoft.com/core/nginx-zkeacms.conf &&
sudo wget http://cdn.zkeasoft.com/core/zkeacms.service &&
sudo rm -rf /etc/nginx/sites-available/default &&
sudo mv nginx-zkeacms.conf /etc/nginx/conf.d/zkeacms.conf -f &&
sudo mv zkeacms.service /etc/systemd/system/zkeacms.service -f &&
sudo systemctl start nginx &&
sudo systemctl start zkeacms &&
sudo systemctl enable nginx &&
sudo systemctl enable zkeacms &&
sudo systemctl restart nginx
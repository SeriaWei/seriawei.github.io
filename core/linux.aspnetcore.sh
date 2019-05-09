#!/bin/sh
echo Downloading dotnet-hosting
sudo rm -rf dotnet-hosting.tar.gz
sudo rm -rf /zkeasoft/dotnet 
sudo mkdir -p /zkeasoft/dotnet
sudo wget -O dotnet-hosting.tar.gz http://www.zkea.net/dotnet-runtime-linux
sudo tar zxf dotnet-hosting.tar.gz -C /zkeasoft/dotnet
sudo rm -rf dotnet-hosting.tar.gz





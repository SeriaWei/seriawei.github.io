sudo rm -rf dotnet-runtime-linux-x64.tar.gz &&
sudo rm -rf aspnetcore-linux-x64.tar.gz &&
sudo rm -rf /zkeasoft/dotnet &&
sudo mkdir -p /zkeasoft/dotnet &&
sudo wget -O dotnet-runtime-linux-x64.tar.gz https://download.microsoft.com/download/1/1/0/11046135-4207-40D3-A795-13ECEA741B32/dotnet-runtime-2.0.5-linux-x64.tar.gz &&
sudo tar zxf dotnet-runtime-linux-x64.tar.gz -C /zkeasoft/dotnet &&
sudo rm -rf dotnet-runtime-linux-x64.tar.gz &&
sudo wget -O aspnetcore-linux-x64.tar.gz https://download.microsoft.com/download/1/1/0/11046135-4207-40D3-A795-13ECEA741B32/aspnetcore-store-2.0.5-linux-x64.tar.gz &&
sudo tar zxf aspnetcore-linux-x64.tar.gz -C /zkeasoft/dotnet &&
sudo rm -rf aspnetcore-linux-x64.tar.gz

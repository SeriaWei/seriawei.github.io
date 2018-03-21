echo Downloading dotnet-hosting &&
sudo rm -rf dotnet-hosting.tar.gz &&
sudo rm -rf /zkeasoft/dotnet &&
sudo mkdir -p /zkeasoft/dotnet &&
sudo wget -O dotnet-hosting.tar.gz https://download.microsoft.com/download/1/1/0/11046135-4207-40D3-A795-13ECEA741B32/dotnet-hosting-2.0.5-linux-x64.tar.gz &&
sudo tar zxf dotnet-hosting.tar.gz -C /zkeasoft/dotnet &&
sudo rm -rf dotnet-hosting.tar.gz





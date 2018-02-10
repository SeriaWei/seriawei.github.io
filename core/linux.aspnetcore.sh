rm -rf dotnet-runtime-linux-x64.tar.gz &&
rm -rf aspnetcore-linux-x64.tar.gz &&
rm -rf /zkeasoft/dotnet &&
mkdir -p /zkeasoft/dotnet &&
wget -O dotnet-runtime-linux-x64.tar.gz https://download.microsoft.com/download/1/1/0/11046135-4207-40D3-A795-13ECEA741B32/dotnet-runtime-2.0.5-linux-x64.tar.gz &&
tar zxf dotnet-runtime-linux-x64.tar.gz -C /zkeasoft/dotnet &&
rm -rf dotnet-runtime-linux-x64.tar.gz &&
wget -O aspnetcore-linux-x64.tar.gz https://download.microsoft.com/download/1/1/0/11046135-4207-40D3-A795-13ECEA741B32/aspnetcore-store-2.0.5-linux-x64.tar.gz &&
tar zxf aspnetcore-linux-x64.tar.gz -C /zkeasoft/dotnet &&
rm -rf aspnetcore-linux-x64.tar.gz

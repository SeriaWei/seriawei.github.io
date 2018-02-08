rm -rf dotnet-runtime.tar.gz && 
rm -rf aspnetcore-store.tar.gz &&
mkdir -p /zkeasoft/dotnet &&
wget -O dotnet-runtime.tar.gz https://download.microsoft.com/download/1/1/0/11046135-4207-40D3-A795-13ECEA741B32/dotnet-runtime-2.0.5-linux-x64.tar.gz &&
wget -O aspnetcore-store.tar.gz https://download.microsoft.com/download/5/C/1/5C190037-632B-443D-842D-39085F02E1E8/aspnetcore-store-2.0.3-linux-x64.tar.gz &&
tar zxf dotnet-runtime.tar.gz -C /zkeasoft/dotnet &&
tar zxf aspnetcore-store.tar.gz -C /zkeasoft/dotnet &&
rm -rf dotnet-runtime.tar.gz && 
rm -rf aspnetcore-store.tar.gz
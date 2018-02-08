rm -rf dotnet.tar.gz && 
rm -rf /zkeasoft/dotnet &&
mkdir -p /zkeasoft/dotnet &&
wget -O dotnet.tar.gz https://download.microsoft.com/download/1/1/5/115B762D-2B41-4AF3-9A63-92D9680B9409/dotnet-sdk-2.1.4-linux-x64.tar.gz &&
tar zxf dotnet.tar.gz -C /zkeasoft/dotnet &&
rm -rf dotnet.tar.gz
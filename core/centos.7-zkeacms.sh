sudo curl http://cdn.zkeasoft.com/core/linux.aspnetcore.sh|sh &&
sudo yum check-update -y &&
sudo yum install libunwind libicu -y &&
sudo yum install zip unzip -y &&
sudo rm -rf cms.zip &&
echo Downloading ZKEACMS package &&
sudo wget -O cms.zip http://zkeasoft-10041459.file.myqcloud.com/core/cms.zip &&
sudo mkdir -p /zkeasoft/cms &&
sudo unzip -o cms.zip -d /zkeasoft/cms &&
sudo wget http://cdn.zkeasoft.com/core/zkeacms.service &&
sudo mv zkeacms.service /etc/systemd/system/zkeacms.service -f &&
sudo systemctl start zkeacms &&
sudo systemctl enable zkeacms

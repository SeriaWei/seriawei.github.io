curl http://cdn.zkeasoft.com/core/linux.aspnetcore.sh|sh &&
apt-get install libunwind-dev -y &&
apt-get install zip unzip -y &&
wget -O cms.zip http://cdn.zkeasoft.com/core/cms.zip &&
mkdir -p /zkeasoft/cms
unzip cms.zip -d /zkeasoft/cms &&
wget http://cdn.zkeasoft.com/core/zkeacms.service &&
mv zkeacms.service /etc/systemd/system/zkeacms.service -f &&
systemctl start zkeacms &&
systemctl enable zkeacms

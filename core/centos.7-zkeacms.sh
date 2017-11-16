sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
sudo sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl=https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo' &&
sudo yum update -y &&
sudo yum install libunwind libicu -y &&
sudo yum install dotnet-sdk-2.0.2 -y &&
sudo yum install zip unzip -y &&
sudo rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm &&
sudo yum install nginx -y &&
sudo wget -O cms.zip http://cdn.zkeasoft.com/core/cms.zip &&
sudo mkdir /zkeasoft &&
sudo mkdir /zkeasoft/cms &&
sudo unzip cms.zip -d /zkeasoft/cms &&
sudo wget http://cdn.zkeasoft.com/core/nginx-zkeacms.conf &&
sudo wget http://cdn.zkeasoft.com/core/zkeacms.service &&
sudo mv nginx-zkeacms.conf /etc/nginx/conf.d/zkeacms.conf -f &&
sudo mv zkeacms.service /etc/systemd/system/zkeacms.service -f &&
sudo mv /etc/nginx/conf.d/default.conf backup-nginx-default.conf &&
sudo systemctl start nginx &&
sudo systemctl start zkeacms &&
sudo systemctl enable nginx &&
sudo systemctl enable zkeacms &&
sudo systemctl restart nginx

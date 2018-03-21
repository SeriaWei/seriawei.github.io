#!/bin/sh
if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
    echo ubuntu.16.04-zkeacms
    sudo curl http://cdn.zkeasoft.com/core/ubuntu.16.04-zkeacms.sh|sh
else
    echo centos.7-zkeacms
    sudo curl http://cdn.zkeasoft.com/core/centos.7-zkeacms.sh|sh
fi
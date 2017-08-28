#/bin/bash

set -e

yum install epel-release -y
yum install docker docker-compose -y
systemctl start docker
chmod a+rw /var/run/docker.sock

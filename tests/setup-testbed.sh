#/bin/bash

set -e

yum install epel-release -y
yum install docker docker-compose -y
systemctl start docker
chmod a+rw /var/run/docker.sock

( mkdir -p /etc/pki/ftp;
  cd /etc/pki/ftp; 
  if [ ! -f ftp.pem ]; then
      openssl req -x509 -newkey rsa:4096 \
		-keyout ftp.key -out ftp.crt \
	        -days 365 -nodes -subj '/CN=192.168.9.9/'
      ln -sf ftp.crt ca.crt
  fi
)

cat <<EOF
Now, start the containers

    vagrant ssh
    cd /vagrant/tests
    docker-compose up

And run ftp from local machine

    ftp  192.168.9.9
    user: test
    pass: test

EOF

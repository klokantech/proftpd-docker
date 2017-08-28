# How to test

Start Vagrant box on testing machine

    vagrant up

Loging to the Vagrant box

    vagrant ssh

Run images in the Vagrant box

    cd /vagrant/tests; make

Try FTP in the second terminal window

    ftp 192.168.9.9
    user: test
    pass test

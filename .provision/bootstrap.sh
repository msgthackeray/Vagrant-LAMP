#!/bin/bash
echo "setting up development virtual machine"

echo "linux Command Time..."

echo "some base installs..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get install -y build-essential  > /dev/null 2>&1
sudo apt-get install -y python-software-properties  > /dev/null 2>&1
sudo apt-get install -y python  > /dev/null 2>&1
sudo apt-get install -y g++  > /dev/null 2>&1
sudo apt-get install -y make  > /dev/null 2>&1
sudo apt-get install -y curl  > /dev/null 2>&1
sudo apt-get install -y git  > /dev/null 2>&1
sudo apt-get install -y wget  > /dev/null 2>&1

echo "installing apache2..."
sudo apt-get install -y apache2 > /dev/null 2>&1

echo "ServerName lamp-dev.local" | sudo tee --append /etc/apache2/apache2.conf > /dev/null 2>&1

sudo systemctl restart apache2 > /dev/null 2>&1
sudo ufw allow in "Apache Full" > /dev/null 2>&1

echo "installing mysql..."
sudo apt-get install -y debconf-utils > /dev/null 2>&1
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

sudo apt-get install -y mysql-server > /dev/null 2>&1

echo "installing php7.0 and a few common modules..."
sudo apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-dev php7.0-mbstring php7.0-gd php7.0-intl php7.0-xml php7.0-mysql php7.0-mcrypt php7.0-zip > /dev/null 2>&1
sudo systemctl restart apache2 > /dev/null 2>&1

sudo cat > /var/www/html/phpinfo.php << EOF
<?php
phpinfo();
EOF

echo "installing composer for php..."
sudo curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1
sudo mv composer.phar /usr/local/bin/composer

echo "installing phpmyadmin..."
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/internal/skip-preseed boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean false"
sudo apt-get install -y phpmyadmin > /dev/null 2>&1
sudo systemctl restart apache2 > /dev/null 2>&1

echo "creating user vdev..."
sudo adduser --disabled-password --gecos "" vdev
sudo usermod -aG sudo vdev
echo vdev:vagrant | sudo chpasswd

echo "+---------------------------------------------------------+"
echo "|                      S U C C E S S                      |"
echo "+---------------------------------------------------------+"
echo "|   You're good to go! You can now view your server at    |"
echo "|                 \"127.0.0.1:3480\" in a browser.        |"
echo "|                                                         |"
echo "|  If you haven't already, I would suggest editing your   |"
echo "|     hosts file with \"127.0.0.1  projectname.vagrant\"  |"
echo "|         so that you can view your server with           |"
echo "|      \"projectname.vagrant/\" instead of \"127.0.0.1/\" |"
echo "|                      in a browser.                      |"
echo "|                                                         |"
echo "|          You can SSH in with vdev / vagrant             |"
echo "|                                                         |"
echo "|        You can login to MySQL with root / oblivion      |"
echo "+---------------------------------------------------------+"







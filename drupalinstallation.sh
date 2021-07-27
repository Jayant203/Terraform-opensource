
#!/bin/bash

#export DEBIAN_FRONTEND=noninteractive


echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
sudo apt-get install -y -q
sudo apt-get update -y
sudo apt-get upgrade -y
#sudo chmod 777 /var/cache/debconf/
#sudo chmod 777 /var/cache/debconf/passwords.dat
#sudo apt-get install dialog apt-utils -y
#echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
#sudo apt-get install -y -q dialog
sudo apt-get install tasksel -y
sudo tasksel install lamp-server

if [ -f /etc/init.d/mysql* ]
then
        echo "Already installed"
else
        sudo mysql -u root -padmin -e "CREATE DATABASE drupal CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
        sudo mysql -u root -padmin -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON drupal.* TO ‘drupaluser’@’localhost’ IDENTIFIED BY 'root';"
fi
D9="drupal-9.2.2"
wget https://ftp.drupal.org/files/projects/$D9.tar.gz
tar -zxf $D9.tar.gz
sudo mkdir /var/www/html/drupal

sudo cp -R $D9/* $D9/.htaccess /var/www/html/drupal
sudo mkdir /var/www/html/drupal/sites/default/files
sudo chown www-data:www-data /var/www/html/drupal/sites/default/files
sudo cp /var/www/html/drupal/sites/default/default.settings.php /var/www/html/drupal/sites/default/settings.php
sudo chown www-data:www-data /var/www/html/drupal/sites/default/settings.php
sudo systemctl restart apache2
sudo sed -i '172s/.*/        AllowOverride All/' /etc/apache2/apache2.conf
sudo systemctl restart apache2

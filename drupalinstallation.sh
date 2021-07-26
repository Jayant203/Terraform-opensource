#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive sudo apt-get install tasksel -y 
DEBIAN_FRONTEND=noninteractive sudo tasksel install lamp-server 
sudo mysql -u root -padmin -e "CREATE DATABASE drupal CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
sudo mysql -u root -padmin -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON drupal.* TO ‘drupaluser’@’localhost’ IDENTIFIED BY 'root';"
wget https://ftp.drupal.org/files/projects/drupal-9.2.0.tar.gz
tar -zxf drupal-9.2.0.tar.gz
sudo mkdir /var/www/html/drupal
sudo cp -R drupal-9.2.0/* drupal-9.2.0/.htaccess /var/www/html/drupal
sudo mkdir /var/www/html/drupal/sites/default/files
sudo chown www-data:www-data /var/www/html/drupal/sites/default/files
sudo cp /var/www/html/drupal/sites/default/default.settings.php /var/www/html/drupal/sites/default/settings.php
sudo chown www-data:www-data /var/www/html/drupal/sites/default/settings.php
sudo systemctl restart apache2
sudo sed -i '172s/.*/        AllowOverride All/' /etc/apache2/apache2.conf
sudo systemctl restart apache2



#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install tasksel -y
sudo tasksel install lamp-server
sudo a2enmod rewrite
sudo systemctl restart apache2
curl --output /tmp/wordpress.zip https://wordpress.org/latest.zip
sudo rm -fr /var/www/html
sudo unzip /tmp/wordpress.zip -d /var/www/
sudo mv /var/www/wordpress/ /var/www/html
sudo chown -R www-data.www-data /var/www/html
sudo mysqladmin create wordpress
sudo mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'pass';"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'%' WITH GRANT OPTION;"
sudo systemctl restart apache2
~                                                                                                                                                                                      
~                                                                                                                                                                                      
~                                                                                     

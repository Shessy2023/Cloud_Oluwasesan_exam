#!/bin/bash

#update your linux system
sudo apt update -y

#install your apache webserver
sudo apt install apache2 -y

#add the php ondrej repository
sudo add-apt-repository ppa:ondrej/php --yes

#update your repository again
sudo apt update -y

# install crontab
sudo apt install cron -y
sudo systemctl enable cron

# install php8.2
sudo apt install php8.2 -y 

#install some of those php dependencies that are needed for laravel to work
sudo apt install php8.2-curl php8.2-dom php8.2-mbstring php8.2-xml php8.2-mysql zip unzip -y

#enable rewrite
sudo a2enmod rewrite

#restart your apache server
sudo systemctl restart apache2

#change directory in the bin directory
cd /usr/bin

#install composer
install composer globally -y
sudo curl -sS https://getcomposer.org/installer | sudo php -q

#move the content of the deafault composer.phar
sudo mv composer.phar composer

#change directory in /var/www directory so we can clone of laravel repo there
cd /var/www/
sudo git clone https://github.com/laravel/laravel.git
sudo chown -R $USER:$USER /var/www/laravel

# Next we cd into the laravel dir and then install the composer autoloader.
cd laravel/
install composer autoloader
composer install --optimize-autoloader --no-dev --no-interaction
composer update --no-interaction

#copy the content of the default env.example file to .env 
sudo cp .env.example .env
sudo chown -R www-data storage
sudo chown -R www-data bootstrap/cache

# then I configure my apache2 server
cd
cd /etc/apache2/sites-available/
sudo touch newest.conf
sudo echo '<VirtualHost *:80>
   ServerName localhost
   DocumentRoot /var/www/laravel/public

   <Directory /var/www/laravel>
       AllowOverride All
   </Directory>

   ErrorLog ${APACHE_LOG_DIR}/laravel-error.log
   CustomLog ${APACHE_LOG_DIR}/laravel-access.log combined
</VirtualHost>' | sudo tee /etc/apache2/sites-available/newest.conf
sudo a2ensite newest.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

#install mysql and create a database
cd
sudo apt install mysql-server -y
sudo apt install mysql-client -y
sudo systemctl start mysql
sudo mysql -uroot -e "CREATE DATABASE Oluwayemi;"
sudo mysql -uroot -e "CREATE USER 'oluwasesan'@'localhost' IDENTIFIED BY 'altschool';"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON Oluwayemi.* TO 'oluwasesan'@'localhost';"

#change directory to the laravel directory
cd /var/www/laravel

#configure the .env file to use mysql; by uncommenting and changing the values of line 22-27 of the .env file
sudo sed -i "23 s/^#//g" /var/www/laravel/.env
sudo sed -i "24 s/^#//g" /var/www/laravel/.env
sudo sed -i "25 s/^#//g" /var/www/laravel/.env
sudo sed -i "26 s/^#//g" /var/www/laravel/.env
sudo sed -i "27 s/^#//g" /var/www/laravel/.env
sudo sed -i '22 s/=sqlite/=mysql/' /var/www/laravel/.env
sudo sed -i '23 s/=127.0.0.1/=localhost/' /var/www/laravel/.env
sudo sed -i '24 s/=3306/=3306/' /var/www/laravel/.env
sudo sed -i '25 s/=laravel/=Oluwayemi/' /var/www/laravel/.env
sudo sed -i '26 s/=root/=oluwasesan/' /var/www/laravel/.env
sudo sed -i '27 s/=/=altschool/' /var/www/laravel/.env

#generate the key and migrate the database
sudo php artisan key:generate
sudo php artisan storage:link
sudo php artisan migrate
sudo php artisan db:seed

#restart the apache2 server
sudo systemctl restart apache2



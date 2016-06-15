#!/usr/bin/env bash

block="
<VirtualHost *:80>
    ServerAdmin jme@emakina.com

    ServerName $1
    ServerAlias *.$1
    DocumentRoot /home/pinobox/www/$2

    ErrorLog /home/pinobox/www/$2/error.log

    DirectoryIndex index.php index.html

    EnableSendfile Off

    <Directory /home/pinobox/www/$2>
        AllowOverride All
        Require all granted
    </Directory>

    <IfModule mod_proxy_fcgi.c>
        # Run php-fpm via proxy_fcgi
        <FilesMatch \.php$>
            SetHandler \"proxy:unix:/var/run/php5-fpm.sock|fcgi://localhost\"
        </FilesMatch>
    </IfModule>
</VirtualHost>
"

echo "$block" > "/etc/apache2/sites-available/$1.conf"
sudo a2ensite "$1"
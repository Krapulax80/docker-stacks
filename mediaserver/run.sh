#!/bin/bash

if [ ! -f /var/www/html/config/ampache.cfg.php.dist ]; then
    echo No configuration found.
    echo Copying standard config.
    cp -r /usr/share/ampache-config/* /var/www/html/config/
    chown -R www-data /var/www/html/config/
fi

chown -R www-data /var/www/html/config/

# remove log files
rm /var/run/apache2 -rf
rm /var/run/lock/* -rf


exec /usr/sbin/apache2ctl -D FOREGROUND

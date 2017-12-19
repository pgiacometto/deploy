#!/usr/bin/env bash
echo '-----NODE + NPM-----'
nodejs -v && npm -v
echo '----PHP-----'
php -v && service php7.0-fpm start && service php7.0-fpm status &&
echo '-----NGINX------'
nginx -v && service nginx start && service nginx status &&
echo '----DONE---'
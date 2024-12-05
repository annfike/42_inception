#!/bin/sh
cd /var/www/html

sleep 10

if [ ! -f /var/www/html/wp-config.php ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    ./wp-cli.phar core download --allow-root --path=/var/www/html
    ./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --allow-root
    ./wp-cli.phar core install --url=adelaloy.42.fr --title=$WP_SITE_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    ./wp-cli.phar user create "$WP_USER" "$WP_USER_EMAIL" --user_pass=$WP_USER_PASSWORD --role=author --allow-root --path='/var/www/html'
fi

exec "$@"

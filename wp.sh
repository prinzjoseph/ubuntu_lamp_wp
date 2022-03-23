wp()
{
        #Creating DB for WP
	#DB name 
	db=$(echo $domain | awk -F. '{print $1}')
	#Create a random password
	passdb=$(openssl rand -base64 12)
	db_ok=$(mysql -e "SHOW DATABASES;" | grep -w "$db")
	if [ "$db_ok" = "" ]; then
		mysql -e "CREATE DATABASE ${db};"
		mysql -e "CREATE USER ${db}@localhost IDENTIFIED BY '${passdb}';"
		mysql -e "GRANT ALL PRIVILEGES ON ${db}.* TO '${db}'@'localhost';"
		mysql -e "FLUSH PRIVILEGES;"
	else
		echo "*** DB $db already exists! ***"
	fi

	#Downloading wordpress
	if [ -d /var/www/$domain ]; then
		echo "*** Documentroot for $domain already exists! ***"
	else
		cd /tmp
        	curl -O https://wordpress.org/latest.tar.gz
        	tar xzf latest.tar.gz
        	rm -rf latest.tar.gz
        	mv /tmp/wordpress /var/www/$domain
        	chown -R www-data:www-data /var/www/$domain
	fi

	if [ -f /etc/apache2/sites-available/$domain.conf ]; then
		echo "*** Configuration file for $domain already exists! ***"
	else
		echo "*** Creating apache configuration file. ***"
		cat >/etc/apache2/sites-available/$domain.conf <<EOL
<VirtualHost *:80>
	ServerName $domain
    	DocumentRoot /var/www/$domain
    	<Directory /var/www/$domain>
        	Options FollowSymLinks
        	AllowOverride All
        	DirectoryIndex index.php
        	Require all granted
    	</Directory>
    	<Directory /var/www/$domain/wp-content>
        	Options FollowSymLinks
        	Require all granted
    	</Directory>
</VirtualHost>
EOL
	a2ensite $domain > /dev/null
	fi
        
	#Removing enabled default apache configuration if exists. 
	if [ -f /etc/apache2/sites-enabled/000-default.conf ]; then
        	rm -rf /etc/apache2/sites-enabled/000-default.conf
	fi


        if apache2ctl -t; then
        	systemctl restart apache2
	else
        	echo "Check apache configuration syntax!" 
	fi

	if [ -f /var/www/$domain/wp-config.php ]; then
		echo "*** WP config file exists! ***"
	else
		mv /var/www/$domain/wp-config-sample.php /var/www/$domain/wp-config.php
		sed -i "s/database_name_here/$db/g" /var/www/$domain/wp-config.php
		sed -i "s/username_here/$db/g" /var/www/$domain/wp-config.php
		sed -i "s%password_here%$passdb%g" /var/www/$domain/wp-config.php
	fi
}

lamp()
{
	echo "*** Checking if Apache is already installed ***"

	if [[ "$ap" = "" ]]; then
		echo "*** Installing Apache ***"
		apt -y -qq install apache2
		#enable apache
		systemctl enable apache2

	else
		echo "*** Apache is already installed ***"
	fi

	echo "*** Checking if Mariadb/Mysql is already installed ***"

	if [[ "$ma" = "" && "$my" = "" ]]; then
		echo "*** Installing Mariadb-Server ***"
		apt -y -qq install mariadb-server
		#enable mariadb
        	systemctl enable mariadb
        	#restart mariadb
        	systemctl restart mariadb

	elif [[ "$ma" = "install ok installed" ]]; then
		echo "*** Mariadb-Server is already installed ***"

	else
		echo "*** Mysql-Server is already installed ***"
	fi

	echo "*** Checking if PHP is already installed ***"

	if [[ $ph = "" ]]; then
		echo "*** Installing PHP ***"
		apt -y -qq install php php7.4-mysqlnd libapache2-mod-php7.4 libapache2-mod-php
        	#restart apache
        	systemctl restart apache2
	else
		echo "*** PHP is already installed ***"
	fi

}

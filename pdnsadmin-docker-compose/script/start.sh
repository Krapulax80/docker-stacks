#!/usr/bin/env bash

# Give time to database to boot up and embedded DNS server ready
sleep 20

# Import schema structure
if [ -e "pdns.sql" ]; then
	mysql --host=database --user=$MYSQL_USER --password=$MYSQL_PASSWORD --database=$MYSQL_DATABASE < pdns.sql
	rm -f pdns.sql

	mysql --host=database --user=root --password=$MYSQL_ROOT_PASSWORD -e "create database ${MYSQL_DATABASE_PDNSADMIN};"
	echo "Imported schema structured"
fi

# Remove all powerdns config and run it as foreground
rm -rf /etc/powerdns/pdns.d/*

/usr/sbin/pdns_server \
       	--launch=gmysql --gmysql-host=database --gmysql-user=$MYSQL_USER --gmysql-dbname=$MYSQL_DATABASE --gmysql-password=$MYSQL_PASSWORD \
       	--webserver=yes --webserver-address=0.0.0.0 --webserver-port=8081 \
		--api=yes --api-key=$PDNS_API_KEY

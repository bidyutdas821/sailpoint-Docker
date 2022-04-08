#!/bin/bash


echo "waiting for database on ${MYSQL_HOST} to come up"
while ! mysqladmin ping -hdb -uroot -ppassword --silent ; do
	echo -ne "."
	sleep 1
done
#check if database schema is already there
export DB_SCHEMA_VERSION=$(mysql -s -N -hdb -uroot -ppassword -e "select schema_version from identityiq.spt_database_version;")

if [ -z "$DB_SCHEMA_VERSION" ]
then
cd /
source ./test.sh

else
echo "=> Database already set up, version "$DB_SCHEMA_VERSION" found, starting IIQ directly";
sed -ri -e "s/mysql:\/\/localhost/mysql:\/\/db/" /opt/tomcat/webapps/identityiq/WEB-INF/classes/iiq.properties

/opt/tomcat/bin/catalina.sh run
fi


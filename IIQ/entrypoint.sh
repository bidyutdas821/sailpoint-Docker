#!/bin/bash
#check environment variables and set some defaults
if [ -z "${MYSQL_HOST}" ]
then
	export MYSQL_HOST=db
fi
if [ -z "${MYSQL_USER}" ]
then
	export MYSQL_USER=root
fi
if [ -z "${MYSQL_PASSWORD}" ]
then
	export MYSQL_PASSWORD=password
fi
#wait for database to start

echo waiting for database on ${MYSQL_HOST} to come up
while ! mysqladmin ping -h"${MYSQL_HOST}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent ; do
	echo -ne "."
	sleep 1
done
echo creating database
mysql -u root -h "${MYSQL_HOST}" -p "${MYSQL_ROOT_PASSWORD}" < source /opt/tomcat/webapps/identityiq/WEB-INF/database/create_identityiq_tables-"${IIQ_VERSION}".mysql

# set database host in properties
sed -ri -e "s/mysql:\/\/localhost/mysql:\/\/${MYSQL_HOST}/" /opt/tomcat/webapps/identityiq/WEB-INF/classes/iiq.properties

echo "No spadmin user in database, setting up database connection in iiq.properties and importing init.xml and init-lcm.xml"
echo "import init.xml" | /opt/tomcat/webapps/identityiq/WEB-INF/bin/iiq console
echo "import init-lcm.xml" | /opt/tomcat/webapps/identityiq/WEB-INF/bin/iiq console
echo "=> Done loading init.xml via iiq console!"



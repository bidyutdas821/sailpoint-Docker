
echo "No schema present, creating IIQ schema in DB"
echo "changing directory to iiq bin"
cd /opt/tomcat/webapps/identityiq/WEB-INF/bin/
echo "running iiq schema"
./iiq schema
echo "changing directory to iiq databse"
cd /opt/tomcat/webapps/identityiq/WEB-INF/database
echo "logging into mysql"
mysql -u root -hdb -ppassword </opt/tomcat/webapps/identityiq/WEB-INF/database/create_identityiq_tables_run.mysql

echo "database script executed"
# set database host in properties
sed -ri -e "s/mysql:\/\/localhost/mysql:\/\/db/" /opt/tomcat/webapps/identityiq/WEB-INF/classes/iiq.properties
cd ../bin
echo "import init.xml" | /opt/tomcat/webapps/identityiq/WEB-INF/bin/iiq console
echo "import init-lcm.xml" | /opt/tomcat/webapps/identityiq/WEB-INF/bin/iiq console
echo "=> Done loading init.xml via iiq console!"
#source ./iiq console<<eof
#import init.xml
#import init-lcm.xml
#eof
echo "test.sh completed"
/opt/tomcat/bin/catalina.sh run

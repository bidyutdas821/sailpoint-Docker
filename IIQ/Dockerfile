
FROM tomcatapp

WORKDIR /opt/tomcat
COPY identityiq.war /opt/temp/
RUN chmod +x /opt/temp/identityiq.war
RUN mkdir /opt/tomcat/webapps/identityiq && \
unzip -qq /opt/temp/identityiq.war -d /opt/tomcat/webapps/identityiq && \
chmod +x /opt/tomcat/webapps/identityiq/WEB-INF/bin/iiq &&\
rm /opt/temp/identityiq.war
COPY ent.sh /ent.sh 
COPY test.sh /test.sh
RUN  cp /opt/tomcat/webapps/identityiq/WEB-INF/database/create_identityiq_tables-8.1.mysql /opt/tomcat/webapps/identityiq/WEB-INF/database/create_identityiq_tables_run.mysql 
RUN chmod +x /*.sh
#CMD ["/opt/tomcat/bin/catalina.sh","run"]
CMD ["/ent.sh"]

EXPOSE 8080
EXPOSE 3306

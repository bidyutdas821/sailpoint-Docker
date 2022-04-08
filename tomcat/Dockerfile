
FROM centos:7

RUN yum install -y unzip
RUN yum install mysql -y

RUN mkdir /opt/tomcat
RUN mkdir /opt/temp && mkdir /opt/java
WORKDIR /opt/temp
COPY apache-tomcat-9.0.58.tar.gz /opt/temp
COPY jre-8u321-linux-x64.tar.gz /opt/temp
RUN tar -xvzf jre-8u321-linux-x64.tar.gz
RUN mv jre1.8.0_321/* /opt/java/.
ENV JAVA_HOME="/opt/java/"
RUN tar -xvzf apache-tomcat-9.0.58.tar.gz
RUN mv apache-tomcat-9.0.58/* /opt/tomcat/.
RUN echo $JAVA_HOME
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin
WORKDIR /
EXPOSE 8080


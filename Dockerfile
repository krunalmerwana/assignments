#Using centos image from DockerHub  
FROM centos:6  
MAINTAINER Krunal Merwana

#RUN sudo su
#Installing gcc
RUN yum install gcc -y  
RUN cd /usr/src
#Installing wget to download the binaries
RUN yum install wget -y
#Downloading Pyhton 2.7 binary file
RUN wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
#Extracting the python file
RUN tar xzf Python-2.7.10.tgz
#Changing the directory
#WORKDIR Python-2.7.10
#Running the configure file for python
RUN Python-2.7.10/configure
#Installing the python Library
RUN make altinstall
#By default CentOs has Python 2.6 to change the default version to 2.7 we need to add the file path to bashrc file
RUN echo "alias python=/usr/local/bin/python2.7" >> /root/.bashrcRUN source /root/.bashrc

#Following command is the configuration of MongoDB
RUN echo -e "\
[mongodb-org-4.2]\n\
name=MongoDB Repository\n\
baseurl=https://repo.mongodb.org/yum/redhat/6Server/mongodb-org/4.2/x86_64/\n\
gpgcheck=1\n\
enabled=1\n\
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc" >> /etc/yum.repos.d/mongodb.repo
RUN yum install -y mongodb-org
#RUN service mongod start

#Creating a Directory for Tomcat installation
RUN mkdir /opt/tomcat/
#Changing the directory
WORKDIR /opt/tomcat
#Downloading tomcat binaries
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.99/bin/apache-tomcat-7.0.99.tar.gz
#Extracting the tar file
RUN tar xzf apache-tomcat-7.0.99.tar.gz
#Moving the directory to /usr/local/tomcat7
RUN mv apache-tomcat-7.0.99 /usr/local/tomcat7
#To run tomcat java needs to be installed so this coomand installs java
RUN yum -y install java
#Starting Tomcat
RUN /usr/local/tomcat7/bin/startup.sh
#Exposing container on port 8080
EXPOSE 8080

#Running Tomcat when starting the container
CMD ["/usr/local/tomcat7/bin/catalina.sh", "run"]
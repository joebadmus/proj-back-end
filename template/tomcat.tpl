#!/bin/bash
set -e

#Add the EPEL repository, and update YUM to confirm your change
sudo yum update -y
#Install Java
yum install java-1.8.0-openjdk-demo.x86_64 -y

mkdir /tmp/tomcat
cd /tmp/tomcat/
curl https://downloads.apache.org/tomcat/tomcat-8/v8.5.56/bin/apache-tomcat-8.5.56.tar.gz -o tomcat8.tar.gz
tar xvf tomcat8.tar.gz
cd apache-tomcat-8.5.56/bin/
./startup.sh
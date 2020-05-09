FROM jenkins/jenkins:2.204

LABEL Author="Paulo Santos" 

#ARG master_image_version="v.5.0.0"
#ENV master_image_version $master_image_version

USER root
RUN apt-get update && apt-get install -y make git openjdk-8-jdk
RUN mkdir /srv/backup && chown jenkins:jenkins /srv/backup

USER jenkins
# Plugin Setup
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Auto Configuration Scripts
#COPY --chown=jenkins:jenkins groovy/* /usr/share/jenkins/ref/init.groovy.d/
# ENV 
# COPY --chown=jenkins:jenkins config/*.properties /var/jenkins_home/config/

# JDK Setup
#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64


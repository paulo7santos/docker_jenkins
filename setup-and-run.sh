#!/usr/bin/env bash

dockerhub_user=paulo7santos

jenkins_port=8080
image_name=jenkins-devops
image_version=0.5.1
container_name=jenkins-051

docker pull jenkins/jenkins:2.204

# if [ ! -d downloads ]; then
#     mkdir downloads
#     curl -o downloads/jdk-8u144-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u144-linux-x64.tar.gz
#     curl -o downloads/jdk-7u80-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u80-linux-x64.tar.gz
#     curl -o downloads/apache-maven-3.5.2-bin.tar.gz http://mirror.vorboss.net/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
# fi



docker stop ${container_name}

# docker build --no-cache -t ${dockerhub_user}/${image_name}:${image_version} .
docker build -t ${dockerhub_user}/${image_name}:${image_version} .

if [ ! -d m2deps ]; then
    mkdir m2deps
fi
if [ -d jobs ]; then
    rm -rf jobs
fi
if [ ! -d jobs ]; then
    mkdir jobs
fi
if [ ! -d jenkins_config]; then
    mkdir jenkins_config
fi
if [ ! -d jenkins_home]; then
    mkdir jenkins_home
fi

docker run -d -p ${jenkins_port}:8080 \
    -v `pwd`/jenkins_backup:/srv/backup \
    -v `pwd`/jenkins_home:/var/jenkins_home \
    --name ${container_name} \
    ${dockerhub_user}/${image_name}:${image_version}     
  #  -v `pwd`/jenkins_downloads:/var/jenkins_home/downloads \
  #  -v `pwd`/jenkins_jobs:/var/jenkins_home/jobs/ \
  #  -v `pwd`/jenkins_m2deps:/var/jenkins_home/.m2/repository/ \
  #  -v $HOME/.ssh:/var/jenkins_home/.ssh/ \
  #  -v `pwd`/jenkins_home:/var/jenkins_home \
  #  -v `pwd`/jenkins_backup:/srv/backup \
  #  -v `pwd`/jenkins_logs:/var/log/jenkins/jenkins.log \
    
     

echo "SUCCESSFUL!" 

exit

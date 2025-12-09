#!/bin/bash
yum update -y

yum install docker -y
systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

docker pull ${docker_image}

docker run -d --name strapi -p 1337:1337 ${docker_image}

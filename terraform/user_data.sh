
set -xe


yum update -y
yum install -y docker awscli
systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user


aws ecr get-login-password --region eu-north-1 \
  | docker login --username AWS --password-stdin shoaib-strapi-image

docker pull ${docker_image}
docker rm -f strapi || true


docker run -d --name strapi -p 1337:1337 \
  -e DATABASE_CLIENT=postgres \
  -e DATABASE_HOST="${db_host}" \
  -e DATABASE_PORT=5432 \
  -e DATABASE_NAME="${db_name}" \
  -e DATABASE_USERNAME="${db_username}" \
  -e DATABASE_PASSWORD="${db_password}" \
  ${docker_image}


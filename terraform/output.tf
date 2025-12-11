output "strapi_url" {
  value = "http://${aws_instance.strapi_ec2.public_ip}:1337"
}

output "rds_endpoint" {
  value = aws_db_instance.strapi_db.address
}


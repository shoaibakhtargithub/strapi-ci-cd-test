variable "aws_region" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "key_name" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "ecr_registry" {
  type = string
  description = "ECR registry host "
}

# DB variables
variable "db_name" {
  type    = string
  default = "strapidb"
}

variable "db_username" {
  type    = string
  default = "strapi"
}

variable "db_password" {
  type = string
  sensitive = true
}

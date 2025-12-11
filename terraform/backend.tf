terraform {
  backend "s3" {
    bucket         = "shoaib-terraform-state-bucket"
    key            = "strapi/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

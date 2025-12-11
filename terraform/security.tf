resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow Strapi & SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Strapi (HTTP)"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shoaib-strapi-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "strapi-rds-sg"
  description = "Allow DB access from Strapi EC2"
  vpc_id      = data.aws_vpc.default.id

  
  ingress {
    description       = "Postgres from strapi"
    from_port         = 5432
    to_port           = 5432
    protocol          = "tcp"
    security_groups   = [aws_security_group.strapi_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shoaib-strapi-rds-sg"
  }
}

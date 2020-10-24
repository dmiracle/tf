terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "example" {
  ami                   = "ami-0947d2ba12ee1ff75"
  instance_type         = "t2.micro"
  vpc_security_group_ids = ["sg-0e97b3c53aa37ee68"]
  subnet_id             = "subnet-007b934a9e5882295"
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}
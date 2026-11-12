terraform {
  required_version = "~>1.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
  backend "local" {
    path = "tfstate/terraform.tfstate"
  }
}
provider "aws" {
  region  = "ap-northeast-2"
  profile = "terraform_user"
}
# resource "aws_instance" "my_ec2" {
#   ami           = "ami-0e1eeb87102d64f40"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "ec2-1513"
#     Owner = "yn151325"
#   }
# }

# output "ec2_id" {
#   value = aws_instance.my_ec2.id
# }

resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg_1513"
  description = "ssh-sg"
  tags = {
    Name  = "ssh-sg-1513"
    Owner = "yn151325"
  }
}
resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress" // "egress" "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_sg.id
}
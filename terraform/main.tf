##Provider Block##
provider "aws" {
    region = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

##Statefile Block##
terraform {
  backend "s3" {
    bucket = "sree-terraform"
    key = "dev"
    region = "us-east-1"
    }
}

##Resource Block##
resource "aws_key_pair" "sree-ec2-key" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "demo-vm" {
  ami           = "ami-026b57f3c383c2eec" # Amazon Linux in us-east-1
  # ami           = "ami-0f58b397bc5c1f2e8" # Ubuntu in Mumbai
  instance_type = "t2.micro"
  key_name      = aws_key_pair.sree-ec2-key.key_name

  tags = {
    Name = "EC2-Using-GHA"
  }

  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource "aws_security_group" "sg" {
  name        = "devops-sg"
  description = "Allow SSH and HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


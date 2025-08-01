variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}

variable "public_key" {
  description = "SSH Public Key"
  type = string
}


variable "key_name" {
  default = "aws-ec2-key"
}

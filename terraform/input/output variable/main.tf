provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "terraform-instance-1" {
  ami           = var.ubuntu-ami
  instance_type = var.ubuntu-instance
  key_name      = var.key-name
  tags = {
    Name  = var.key-name
    appid = "terraform"
    env   = "dev"
  }
  availability_zone = "ca-central-1a"
}

variable "ubuntu-ami" {
    description = "this the value for the ubuntu AMI"
    type = string
    default = "ami-0c4596ce1e7ae3e68"

}

variable "ubuntu-instance" {
    default = "t2.micro"
}

variable "key-name" {
    default = "ca-central-1"
}

variable "tags" {
    default = "key-name"
}
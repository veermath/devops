provider "aws" {
    region = "ca-central-1"
}

resource "aws_instance" "terraform-instance-1" {
  ami           = "ami-0c4596ce1e7ae3e68"
  instance_type = "t2.micro"
  key_name      = "ca-central-1"
  tags = {
    Name  = "my-ec2-instance"
    appid = "terraform"
    env   = "dev"
  }
  availability_zone = "ca-central-1a"
}
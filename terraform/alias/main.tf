provider "aws" {
    region = "ca-central-1"
}

provider "aws" {
    alias = "us"
    region = "us-east-1"
}

resource "aws_instance" "terraform-instance" {
    provisioner "name" {
    
    }
}
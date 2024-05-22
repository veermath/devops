provider "aws" {
    region = "ca-central-1"
}

resource "aws_instance" "terraform-instance" {
    ami           = "ami-0c4596ce1e7ae3e68"
  instance_type = "t2.micro"
  key_name      = "ca-central-1"
  tags = {
    Name  = "my-ec2-instance"
    appid = "terraform"
    env   = "dev"
  }
  availibility_zone = "ca-central-1a"
  vpc_security_group_ids = ["sg-0e7fc01a860b01623"]

  connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
      private_key = file("./ca-central-1.pem")
  }
  provisioner "file" {
      source = "./inline.sh"
      destination = "/home/ubuntu/inline.sh"
      
  }

  provisioner "remote-exec" {
      inline = [
          "sh /home/ubuntu/inline.sh"
          "sudo apt-get install maven -y"
      ]
  }
}
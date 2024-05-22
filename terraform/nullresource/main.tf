provider "aws" {
    region = "ca-central-1"
}

data "aws_instance" "managed-server" {
    instance_id = ""
}

resource "null_resource" "my-existing-server" {
    connection {
        type = "SSH"
        user = "ubuntu"
        host = data.aws_instance.my-existing-server.public_ip
        private_key = file("./ca-central-1.pem")
    }

    provisioner "remote-exec" {
        script = "./test.sh"
    }
    provisioner "remote-exec" {
        
    }

    provisioner "local-exec" {
        
    
    }
}
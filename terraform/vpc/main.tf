provider "aws" {
    region = "ca-central-1"
}

resource "aws_vpc" "terraform_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MY_VPC"
    }
}

resource "aws_subnet" "terraform-subnet" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ca-central-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "My-public-subnet-1a"
    }
}

resource "aws_subnet" "terraform-subnet-1" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ca-central-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "My-public-subnet-1b"
    }
}  

resource "aws_internet_gateway" "terraform-igw" {
    vpc_id = aws_vpc.terraform_vpc.id
    tags = {
        Name = "my-igw"
    }
}

resource "aws_route_table" "terraform-pub-rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }
  tags = {
      Name = "my-pub-rt"
  }
}

resource "aws_route_table_association" "terraform-subnet-association" {
  subnet_id      = aws_subnet.terraform-subnet.id
  route_table_id = aws_route_table.terraform-pub-rt.id
}

resource "aws_route_table_association" "terraform-subnet-association-1" {
  subnet_id      = aws_subnet.terraform-subnet-1.id
  route_table_id = aws_route_table.terraform-pub-rt.id
}

resource "aws_security_group" "terraform-sg" {
  name        = "allow_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terraform_vpc.id

  tags = {
    Name = "my-sg-traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "terraform-ingress-rule" {
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv4         = aws_vpc.terraform_vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "terraform-ingress-rule-all-traffic" {
  security_group_id = aws_security_group.terraform-sg.id
#   cidr_ipv4         = aws_vpc.terraform_vpc.cidr_block
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "terraform-instance-1" {
  ami           = "ami-0c4596ce1e7ae3e68"
  instance_type = "t2.micro"
  key_name      = "ca-central-1"
  subnet_id = aws_subnet.terraform-subnet.id
  vpc_security_group_ids = [aws_security_group.terraform-sg.id]
  tags = {
    Name  = "my-ec2-instance"
    appid = "terraform"
    env   = "dev"
  }
}
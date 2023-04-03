terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
  region  = "us-east-1"
}
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 enable_dns_hostnames= true

 tags = {
   Name = "Project VPC"
 }
}
resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.public_subnet_cidrs[*], count.index)
  map_public_ip_on_launch = true
 availability_zone = element(var.azs, count.index)
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.private_subnet_cidrs[*], count.index)
  map_public_ip_on_launch = true
 availability_zone = element(var.azs, count.index)
 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}
resource "aws_internet_gateway" "intgw" {
 vpc_id = aws_vpc.main.id
 tags = {
   Name = "Project VPC INTERNET"
 }
}
resource "aws_route_table" "int_table" {
 vpc_id = aws_vpc.main.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.intgw.id
 }
 tags = {
   Name = "Internet Route Table"
 }
}
resource "aws_route_table_association" "rta_subnet_public" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.int_table.id
}
resource "aws_eip" "one" {
  vpc        = true
  depends_on = [aws_internet_gateway.intgw]
}
 resource "aws_instance" "server_1" {
  subnet_id     = aws_subnet.public_subnets[0].id
  ami           = "ami-02f3f602d23f1659d"
	key_name      =  aws_key_pair.generated_key.key_name
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.publica.id]
}
 resource "aws_instance" "server_2" {
   subnet_id     = aws_subnet.public_subnets[0].id
  ami           = "ami-09b6670f8df6d4e69"
	key_name      =  aws_key_pair.generated_key.key_name
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.publica.id]
}
 resource "aws_instance" "server_3" {
   subnet_id     = aws_subnet.public_subnets[0].id
  ami           = "ami-0fec2c2e2017f4e7b"
	key_name      =  aws_key_pair.generated_key.key_name
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.publica.id]
}
 resource "aws_instance" "server_4" {
   subnet_id     = aws_subnet.public_subnets[0].id
  ami           = "ami-0c9978668f8d55984"
	key_name      =  aws_key_pair.generated_key.key_name
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.publica.id]
}
  resource "aws_instance" "jump_server" {
  subnet_id     = aws_subnet.public_subnets[0].id
  ami           = "ami-00c39f71452c08778"
	key_name      =  aws_key_pair.generated_key.key_name
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.publica.id]
  tags = {
    Name = "jump-server"
  }  
 
}
resource "tls_private_key" "demo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "demo_key_pair" {
  key_name   = "privada_jumpserver_key"
  public_key = tls_private_key.demo_key.public_key_openssh
}
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_name
  public_key = var.public_key
}
resource "aws_security_group" "publica" {
  vpc_id       = aws_vpc.main.id
 name         = "My VPC Public Security Group"
  description  = "My VPC  Public Security Group"
    ingress {
    cidr_blocks =  ["0.0.0.0/0"] 
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
}

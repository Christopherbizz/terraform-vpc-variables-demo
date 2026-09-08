provider "aws" {
    region = var.region

}

//EC2 Configurations
resource "aws_instance" "demo-server" {
    ami                    = var.ami
    key_name               = var.key
    instance_type          = var.instance-type
    subnet_id              = aws_subnet.demo-subnet.id 
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]  // Corrected reference
    availability_zone      = "us-east-1d"
}
 
// Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc-cidr
}

// Create Subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id  // Reference the VPC ID using aws_vpc.demo-vpc.id
  cidr_block = var.subnet1-cidr
  availability_zone = var.az1

  tags = {
    Name = "demo-subnet"
  }
}

// Create Internet Gateway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id  // Reference the VPC ID using aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

// Create Route Table
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id  // Reference the VPC ID using aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "demo-rt"
  }
}

//Associate Subnets to the Route Table
resource "aws_route_table_association" "demo-rt-association" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}
//Create a Security Group

resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
  vpc_id      = aws_vpc.demo-vpc.id
   
ingress {

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.allowed_ssh_cidr]

}

egress {
  
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]

}
}

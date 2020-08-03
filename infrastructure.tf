# VPC with variable CIDR
resource "aws_vpc" "vpc_west_1" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "vpc_west_1"
  }
}

#Subnets
resource "aws_subnet" "sub-public" {
  vpc_id            = aws_vpc.vpc_west_1.id
  cidr_block        = var.sub_cidr_block[0]
  availability_zone = var.az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "sub-public"
  }
}

resource "aws_subnet" "sub-private" {
  vpc_id     = aws_vpc.vpc_west_1.id
  cidr_block = var.sub_cidr_block[1]
  availability_zone = var.az[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "sub-private"
  }
}


# Route tables
resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.vpc_west_1.id  
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

    tags = {
    Name = "rt-pub"
  } 
}

resource "aws_route_table" "rt-pr" {
  vpc_id = aws_vpc.vpc_west_1.id  
  
    tags = {
    Name = "rt-pr"
  }
}

# Route table associations
resource "aws_route_table_association" "route_assoc_pub" {
  subnet_id      = aws_subnet.sub-public.id
  route_table_id = aws_route_table.rt-pub.id
}

resource "aws_route_table_association" "route_assoc_pr" {
  subnet_id      = aws_subnet.sub-private.id
  route_table_id = aws_route_table.rt-pr.id
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_west_1.id

  tags = {
    Name = "igw_west_1"
  }
}

#security groups
resource "aws_security_group" "secgroup-pub" {
  name = "secgroup-pub"
  description = "Public Security Group"
  vpc_id      = aws_vpc.vpc_west_1.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }    

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }    

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secgroup-pub"
  }
}

resource "aws_security_group" "secgroup-pr" {
  name = "secgroup-pr"
  description = "Private Security Group"
  vpc_id      = aws_vpc.vpc_west_1.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.sub_cidr_block[0]]
  }

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = [var.sub_cidr_block[0]]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secgroup-pr"
  }
}


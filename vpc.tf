# Arquivo que contém os recursos de VPC e subnets publicas e privadas

resource "aws_vpc" "main_vpc" {
  cidr_block = "192.168.0.0/16"
  
  tags = {
    Name = "vpc_prova"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet_Gatway"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "$(var.region)a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "$(var.region)b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2"
  }
}

#
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

# public route table associate 1
resource "aws_route_table_association" "public_rt_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# public route table associate 2
resource "aws_route_table_association" "public_rt_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "$(var.region)a"

  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "$(var.region)b"

  tags = {
    Name = "private_subnet_2"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpcs.id
  
  tags = {
    Name = "private_route_table"
  }
}

# private route table associate_1
resource "aws_route_table_association" "private_rt_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

# private route table associate_2
resource "aws_route_table_association" "private_rt_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}
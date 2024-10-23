# Arquivo que contém os recursos de VPC e subnets publicas e privadas

resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"
  
  tags       = {
    Project  = "prova-tecnica-ps"
    Name     = "VPC-Terraform"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags   = {
    Name = "Terraform IGW "
  }
}

# Primeira subnet privada
resource "aws_subnet" "priv-sub1" {
  #for_each = {
  #  "pub_a" : ["192.168.1.0/24", "${var.region}a", "Public A"]
  #  "pub_c" : ["192.168.2.0/24", "${var.region}c", "Public C"]
  #  "pvt_a" : ["192.168.3.0/24", "${var.region}a", "Private A"]
  #  "pvt_c" : ["192.168.4.0/24", "${var.region}c", "Private C"]
  #}

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = { 
    Project = "prova-tecnica-ps"
    Name = "priv-sub1"
  }
}

# Segunda subnet privada
resource "aws_subnet" "priv-sub2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = { 
    Project = "prova-tecnica-ps"
    Name = "priv-sub2"
  }
}

# Primeira subnet publica
resource "aws_subnet" "public-sub1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = { 
    Project = "prova-tecnica-ps"
    Name = "public-sub1"
  }
}

# Segunda subnet publica
resource "aws_subnet" "public-sub2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = { 
    Project = "prova-tecnica-ps"
    Name = "public-sub2"
  }
}

# Tabela de rotas para a subnet publica 1
resource "aws_route_table" "public_rt_1" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = { 
    Project = "prova-tecnica-ps"
    Name = "route table public subnet1"
  }
}

# Tabela de rotas para a subnet publica 2
resource "aws_route_table" "public_rt_2" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = { 
    Project = "prova-tecnica-ps"
    Name = "route table public subnet2"
  }
}

# Criando associação na tabela de rotas para a subnet publica 1
resource "aws_route_table_association" "internet_for_pub_sub1" {
  subnet_id      = aws_subnet.public-sub1.id
  route_table_id = aws_route_table.public_rt_1.id
}

# Criando associação na tabela de rotas para a subnet publica 2
resource "aws_route_table_association" "internet_for_pub_sub2" {
  subnet_id      = aws_subnet.public-sub2.id
  route_table_id = aws_route_table.public_rt_2.id
}

# Tabela de rotas para a subnet privada 1
resource "aws_route_table" "private_rt_1" {
  count = "1"
  vpc_id = aws_vpc.this.id
  
  route {
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Project = "prova-tecnica-ps"
    Name = "route table private subnet1"
  }
}

# Tabela de rotas para a subnet privada 2
resource "aws_route_table" "private_rt_2" {
  count = "1"
  vpc_id = aws_vpc.this.id
  
  route {
    cidr_block = "0.0.0.0/0"
  }

   
}

# Criando associação na tabela de rotas para a subnet privada 1
resource "aws_route_table_association" "internet_for_priv_sub1" {
  subnet_id = aws_subnet.priv-sub1
  route_table_id = aws_route_table.private_rt_1
}

# Criando associação na tabela de rotas para a subnet privada 2
resource "aws_route_table_association" "internet_for_priv_sub2" {
  subnet_id = aws_subnet.priv-sub2
  route_table_id = aws_route_table.private_rt_2
}
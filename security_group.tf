# Arquivo para administrar os security groups da ec2 e rds

# Security group WP
resource "aws_security_group" "sg_sg" {
  name        = var.name_security_group
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Project = "prova-tecnica-ps"
    Name = "SG_WP"
  }
}

# Security group RDS
resource "aws_security_group" "sg_rds" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.allow_ssh.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "prova-tecnica-ps"
    Name = "SG_RDS"
  }
}

# Security group ELB
resource "aws_security_group" "sg_elb" {
  vpc_id = aws.vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Project = "prova-tecnica-ps"
    Name = "SG_ELB"
  }
}

# Recurso que cria uma regra para o security group da EC2_Wordpress ter acesso ao banco RDS
resource "aws_security_group_rule" "rds_ingress" {
  type                     = "ingress"
  security_group_id        = aws_security_group.allow_ssh.id
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.allow_ssh.id
}


## Security group VPN
#resource "aws_security_group" "allow_monitor" {
#  
#}
#
## Security group EC2-Docker
#resource "aws_security_group" "EC2-Docker_allow_rule" {
#  vpc_id = aws_vpc.this.id
#
#  ingress {
#    from_port       = 
#    to_port         = 
#    protocol        = "tcp"
#    security_groups = ["${aws_security_group.allow_ssh.id}"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = -1
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = {
#    Name = "Allow_RDS"
#  }
#}

# Máquina ec2 com script para realizar download do ansible e arquivos para instalação do wordpress+prometheus+grafana

resource "aws_instance" "wordpress" {
  ami                    = var.ami_aws_instance
  instance_type          = var.type_aws_instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = var.key_aws_instance
  user_data = templatefile("ec2_setup.sh",
    {
      wp_db_name       = aws_db_instance.bd_wordpress.name
      wp_username      = aws_db_instance.bd_wordpress.username
      wp_user_password = aws_db_instance.bd_wordpress.password
      wp_db_host       = aws_db_instance.bd_wordpress.address
  })
  monitoring                  = true
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true

  tags = {
    Name = "ec2_wordpress"
  }
}

# Gerando uma chave privada .pem para acesso a instância
resource "tls_private_key" "chave_prova_ps" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Salvando a chave .pem em um arquivo e salvando o mesmo no meu pc
resource "local_file" "private_key_pem" {
  content  = tls_private_key.chave_prova_ps.private_key_pem
  filename = "${pathexpand("~/Downloads")}/(var.key_aws_instance)"
}
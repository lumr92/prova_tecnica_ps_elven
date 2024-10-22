# Máquina ec2 com script para realizar download do ansible e arquivos para instalação do wordpress+prometheus+grafana

resource "aws_instance" "maquina" {
  ami                    = var.ami_aws_instance
  instance_type          = var.type_aws_instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = var.key_aws_instance
  user_data = templatefile("ec2_setup.sh",
    {
      wp_db_name       = aws_db_instance.this.name
      wp_username      = aws_db_instance.this.username
      wp_user_password = aws_db_instance.this.password
      wp_db_host       = aws_db_instance.this.address
  })
  monitoring                  = true
  subnet_id                   = aws_subnet.this["pub_a"].id
  associate_public_ip_address = true

  tags = {
    Name = "Terraform_com_ansible_e_wordpress"
  }
}
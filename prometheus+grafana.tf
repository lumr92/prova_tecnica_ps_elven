# Arquivo com os dados de criação da instância ec2 para monitoramento com prometheus+grafana

resource "aws_instance" "monitor" {
  ami                         = var.ami_aws_instance
  instance_type               = var.type_aws_instance
  vpc_security_group_ids      = [aws_security_group.allow_monitor.id]
  key_name                    = var.key_aws_instance
  user_data                   = base64encode(templatefile("monitor_setup.sh",  {}))
  monitoring                  = true
  subnet_id                   = aws_subnet.this["pub_a"].id
  associate_public_ip_address = true
  tags                        = merge(local.common_tags, { Name = "Monitor Machine" })
}
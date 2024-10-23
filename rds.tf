# Arquivo com recurso de criação da rds

resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.id
  vpc_security_group_ids = ["${aws_security_group.RD_allow_rule.id}"]
  db_name                = var.db_name 
  username               = var.username
  password               = var.password
  port                   = var.port
  identifier             = var.identifier
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = var.skip_final_snapshot

  # Certificando que as alterações manuais de senha rds sejam ignoradas
  lifecycle {
    ignore_changes = [password]
  }
}
 
# Recurso que liga as subnets privadas A e C ao banco RDS
resource "aws_db_subnet_group" "db_subnet" {
  name = "dbsubnet"
  subnet_ids = [
    aws_subnet.priv-sub1.id,
    aws_subnet.priv-sub2.id
  ]
}
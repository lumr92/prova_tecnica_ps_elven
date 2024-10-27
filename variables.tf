variable "region" {
  description = "nome da região"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "conta aws que será utilizada"
  type        = string
  default     = "conta-aws-estudos"
}

variable "name_security_group" {
  description = "nome do security group"
  type        = string
  default     = "allow_ssh"
}

variable "vpc_id_security_group" {
  description = "valor do id da vpc"
  type        = string
  default     = "vpc-0c1393541b3b19e49"
}

variable "ami_aws_instance" {
  description = "ami da instancia"
  type        = string
  default     = "ami-081a3b9eded47f0f3"
}

variable "type_aws_instance" {
  description = "tipo da instancia"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id_aws_instance" {
  description = "valor da subnet da instancia"
  type        = string
  default     = "subnet-0b27acd13f4df0a9e"
}

variable "key_aws_instance" {
  description = "chave pem para acessar a instancia"
  type        =  string
  default     = "prova-tec-ps"
}

variable "engine" {
  description = "qual sistema de bd"
  type        = string
  default     = "mysql"
}

variable "allocated_storage" {
  description = "quantidade de armazenamento alocado"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "tipo de armazenamento"
  type        = string
  default     = "gp3"
}

variable "username" {
  description = "usuário do db"
  default     = "databaseteste"
  type        = string
}

variable "password" {
  description = "senha do bd"
  default     = "password"
  type        = string
}

variable "instance_class" {
  description = "classe da instancia rds"
  default     = "db.t2.micro"
  type        = string
}

variable "parameter_group_name" {
  description = "nome dos parametros associados ao db"
  default     = "default.mysql5.7"
  type        = string
}

variable "engine_version" {
  description = "The engine version"
  default     = "5.7"
  type        = number
}

variable "skip_final_snapshot" {
  description = "skip snapshot"
  default     = "true"
  type        = string
}

variable "identifier" {
  description = "nome da instância RDS"
  default     = "terraform-database-test"
  type        = string
}

variable "port" {
  description = "porta que o bd irá aceitar conexões"
  default     = "3306"
  type        = number
}

variable "db_name" {
  description = "nome do banco de dados"
  default     = "Mysqldatabase"
  type        = string
}
locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  common_tags = {
    Project   = "Projeto Final Bootcamp Elven Works"
    CreatedAt = "2023-05-02"
    ManagedBy = "Terraform"
    Owner     = "Lucas Rodrigues"
    Service   = "Wordpress Turbinado"
  }
}
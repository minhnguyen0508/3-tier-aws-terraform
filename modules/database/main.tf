resource "aws_db_subnet_group" "db" {
  name       = "tier3-db-subnets"
  subnet_ids = var.db_subnet_ids
}

resource "aws_db_parameter_group" "mysql" {
  name   = "tier3-mysql80"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

resource "aws_db_instance" "main" {
  identifier = "tier3-db"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_encrypted = true

  db_name                     = var.db_name
  username                    = var.db_user
  manage_master_user_password = true # password generated and kept in Secrets Manager

  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [var.db_sg_id]
  parameter_group_name   = aws_db_parameter_group.mysql.name
  publicly_accessible    = false

  multi_az                = var.multi_az
  backup_retention_period = 7 # lower to 1 if your account rejects 7
  backup_window           = "03:00-04:00"

  skip_final_snapshot = true # lab only
}


resource "aws_db_subnet_group" "rds" {
  name       = "${var.project_name}-db-subnet"
  subnet_ids = aws_subnet.private_db[*].id

  tags = {
    Name = "${var.project_name}-db-subnet"
  }
}

resource "aws_db_instance" "mysql" {
  identifier              = "${var.project_name}-rds"
  engine                  = "mysql"
  instance_class          = var.rds_instance_class
  allocated_storage       = var.rds_allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  username                = var.rds_username
  password                = var.rds_password
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  deletion_protection     = false
  publicly_accessible     = false
  db_name                 = var.db_name
}

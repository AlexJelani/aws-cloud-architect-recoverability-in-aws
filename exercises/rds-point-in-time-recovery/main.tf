provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-access"
  description = "Allow MySQL inbound traffic"

  ingress {
    description = "MySQL from anywhere"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "rpo_demo" {
  identifier           = "rpo-demo-db"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  
  username            = "admin"
  password            = "password123!"
  
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"
  
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  copy_tags_to_snapshot = true
}

output "db_endpoint" {
  value = aws_db_instance.rpo_demo.endpoint
}
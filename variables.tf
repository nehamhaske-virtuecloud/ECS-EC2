variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Prefix name for resources"
  type        = string
  default     = "ecs-ec2-3tier"
}

variable "vpc_cidr" {
  description = "CIDR for the main VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "Web tier subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnets" {
  type        = list(string)
  description = "App tier subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_db_subnets" {
  type        = list(string)
  description = "DB tier subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "key_pair_name" {
  description = "Name of SSH key pair"
  type        = string
}

variable "rds_password" {
  description = "DB master password"
  type        = string
  sensitive   = true
}

variable "rds_username" {
  description = "DB master username"
  default     = "admin"
}

variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Storage in GB"
  default     = 20
}

variable "db_name" {
  description = "Initial DB name"
  default     = "appdb"
}

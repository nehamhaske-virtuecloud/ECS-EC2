# ------------------------
# General Project Settings
# ------------------------

variable "project_name" {
  description = "Project name used for tagging AWS resources"
  type        = string
}

# ------------------------
# Networking Configuration
# ------------------------

variable "vpc_cidr_block" {
  description = "CIDR block for the main VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "List of CIDR blocks for public subnets (e.g., web tier)"
  type        = list(string)
}

variable "private_subnet_cidr_app" {
  description = "List of CIDR blocks for private subnets (e.g., app tier)"
  type        = list(string)
}

variable "private_subnet_cidr_db" {
  description = "List of CIDR blocks for private subnets (e.g., db tier)"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones (e.g., [\"ap-south-1a\", \"ap-south-1b\"])"
  type        = list(string)
}

# ------------------------
# EC2 Settings
# ------------------------

variable "instance_type" {
  description = "EC2 instance type (e.g., t2.micro)"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "allowed_ip" {
  description = "Public IP or CIDR block allowed to SSH/HTTP (e.g., 0.0.0.0/0 or your IP)"
  type        = string
}

# ------------------------
# RDS Settings
# ------------------------

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the RDS database to create"
  type        = string
}

variable "ecs_min_capacity" {
  description = "Min ECS EC2 instances per tier"
  type        = number
  default     = 2
}

variable "ecs_max_capacity" {
  description = "Max ECS EC2 instances per tier"
  type        = number
  default     = 4
}

variable "web_image" {
  description = "Docker image URI for Web container"
  type        = string
}

variable "app_image" {
  description = "Docker image URI for App container"
  type        = string
}

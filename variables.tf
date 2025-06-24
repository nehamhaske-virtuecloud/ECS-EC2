
variable "region" {
  description = " AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging AWS resources"
  type        = string
}


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
  description = "List of CIDRs for RDS DB private subnets"
  type        = list(string)
}




variable "availability_zones" {
  description = "List of availability zones (e.g., [\"ap-south-1a\", \"ap-south-1b\"])"
  type        = list(string)
}

variable "instance_type" {
  default = "t2.micro"
}
variable "desired_capacity" {
  default = 1
}
variable "max_size" {
  default = 2
}
variable "min_size" {
  default = 1
}

variable "db_name" {
  default     = "appdb"
  description = "The name of the RDS database"
}

variable "db_username" {
  default     = "admin"
  description = "Master username"
}

variable "db_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

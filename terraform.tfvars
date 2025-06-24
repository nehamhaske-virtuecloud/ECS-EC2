region               = "ap-south-1"
project_name         = "ecs-ec2-app"
vpc_cidr_block       = "10.0.0.0/16"

public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_app  = ["10.0.3.0/24", "10.0.4.0/24"]
private_subnet_cidr_db = ["10.0.5.0/24", "10.0.6.0/24"]
availability_zones   = ["ap-south-1a", "ap-south-1b"]
db_password = "AdminPassword#123"  
instance_type   = "t2.micro"
desired_capacity = 1
min_size        = 1
max_size        = 2

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the created VPC"
}

output "public_subnet_ids" {
  value       = [for s in aws_subnet.public : s.id]
  description = "IDs of the public subnets"
}

output "private_subnet_ids_app" {
  value       = [for s in aws_subnet.private_app : s.id]
}

output "private_subnet_ids_db" {
  value       = [for s in aws_subnet.private_db : s.id]
  description = "IDs of DB private subnets"
}


output "alb_dns_name" {
  value       = aws_lb.ecs_alb.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.app_db.endpoint
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.ecs_cluster.name
  description = "Name of the ECS Cluster"
}

output "ecs_service_name" {
  value       = aws_ecs_service.app.name
  description = "Name of the ECS Service"
}

output "ecr_repo_url" {
  value       = aws_ecr_repository.app.repository_url
  description = "URL of the ECR Repository"
}

output "asg_name" {
  value = aws_autoscaling_group.ecs_asg.name
}
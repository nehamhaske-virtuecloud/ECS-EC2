output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_app_subnet_ids" {
  value = [for subnet in aws_subnet.private_app : subnet.id]
}

output "private_db_subnet_ids" {
  value = [for subnet in aws_subnet.private_db : subnet.id]
}

output "nat_gateway_ip" {
  value = aws_eip.nat.public_ip
}

output "region" {
  value = var.aws_region
}

output "ecs_ami_id" {
  value = data.aws_ami.ecs_ami.id
}

output "ecr_repo_url" {
  value = aws_ecr_repository.app_repo.repository_url
}


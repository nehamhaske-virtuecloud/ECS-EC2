resource "aws_ecs_service" "web_svc" {
  name            = "${var.project_name}-web-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.web_task.arn
  desired_count   = 2
  launch_type     = "EC2"

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.web_cp.name
    weight            = 1
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.web_tg.arn
    container_name   = "web"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.web]
}

resource "aws_ecs_service" "app_svc" {
  name            = "${var.project_name}-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type     = "EC2"

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.app_cp.name
    weight            = 1
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "app"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.app]
}

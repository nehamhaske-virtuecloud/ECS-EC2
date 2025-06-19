resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.project_name}-ecs-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = "${var.project_name}-ecs-profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_launch_template" "ecs" {
  name_prefix   = "${var.project_name}-ecs-"
  image_id      = data.aws_ami.ecs_ami.id
  instance_type = var.instance_type

  iam_instance_profile { name = aws_iam_instance_profile.ecs_profile.name }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
EOF)
}

resource "aws_autoscaling_group" "ecs_asg_web" {
  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }
  min_size            = var.ecs_min_capacity
  max_size            = var.ecs_max_capacity
  vpc_zone_identifier = values(aws_subnet.public)

  tag {
    key                 = "Name"
    value               = "${var.project_name}-ecs-web"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "ecs_asg_app" {
  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }
  min_size            = var.ecs_min_capacity
  max_size            = var.ecs_max_capacity
  vpc_zone_identifier = values(aws_subnet.private_app)

  tag {
    key                 = "Name"
    value               = "${var.project_name}-ecs-app"
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "web_cp" {
  name = "${var.project_name}-web-cp"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs_asg_web.arn
    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 75
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 2
    }
    managed_termination_protection = "ENABLED"
  }
}

resource "aws_ecs_capacity_provider" "app_cp" {
  name = "${var.project_name}-app-cp"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs_asg_app.arn
    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 75
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 2
    }
    managed_termination_protection = "ENABLED"
  }
}

resource "aws_ecs_cluster_capacity_providers" "cp_attach" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = [aws_ecs_capacity_provider.web_cp.name, aws_ecs_capacity_provider.app_cp.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.web_cp.name
    weight            = 1
  }
}

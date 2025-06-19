resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

resource "aws_launch_template" "ecs" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.ecs_ami.id
  instance_type = "t3.micro"
  key_name      = var.key_pair_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_profile.name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ecs_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo "ECS_CLUSTER=${aws_ecs_cluster.main.name}" >> /etc/ecs/ecs.config
EOF
  )
}

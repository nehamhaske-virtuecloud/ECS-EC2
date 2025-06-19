resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix               = "${var.project_name}-asg-"
  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 1
  vpc_zone_identifier       = aws_subnet.private_app[*].id
  health_check_type         = "EC2"
  force_delete              = true

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-ecs-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_launch_template.ecs]
}

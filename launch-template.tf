resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "${var.project_name}-lt"
  image_id = data.aws_ami.ecs_ami.id
  instance_type = var.instance_type
  user_data     = base64encode(file("ecs-userdata.sh"))

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
}
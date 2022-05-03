# Create Launch Template

resource "aws_launch_template" "launch_template" {
  name                   = "${var.app_name}-Launch-Template"
  description            = "Launch template for ${var.app_name}."
  image_id               = data.aws_ami.amazon-2.id
  user_data              = filebase64("scripts/init.sh")
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web-server-sg.id]

    tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-Launch-Template"
    },
  )

  iam_instance_profile {
    arn  = aws_iam_instance_profile.asg_profile.arn
  }

}

# Create EC2 Auto Scaling Group

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.app_name}-ASG"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.private01.id, aws_subnet.private02.id]
  target_group_arns         = [ aws_lb_target_group.http.arn]

    tag {
    key                 = "Name"
    value               = "${var.app_name}-ASG"
    propagate_at_launch = true
  }

  launch_template {
    id = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  timeouts {
    delete = "15m"
  }
}
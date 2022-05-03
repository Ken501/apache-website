#Create Load Balancer

resource "aws_lb" "lb" {
  name               = "${var.app_name}-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-server-sg.id]
  subnets            = local.public_subnet_ids[*]

  enable_deletion_protection = false

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-LB"
    },
  )
}

#LB Listeners

resource "aws_lb_target_group" "http" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}
# Create Apache web server security group

resource "aws_security_group" "web-server-sg" {
  name        = "${var.app_name}-server-SG"
  description = "${var.app_name}-server-SG"
  vpc_id      = aws_vpc.main.id

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-server-SG"
    },
  )
}

resource "aws_security_group_rule" "workstation_http_ingress" {
  cidr_blocks              = ["0.0.0.0/0"]
  description              = "Allow https communication with development workstation"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web-server-sg.id
  type                     = "ingress"
}
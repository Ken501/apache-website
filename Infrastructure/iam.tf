# Auto Scaling Group IAM Role

resource "aws_iam_instance_profile" "asg_profile" {
  name = "${var.app_name}-ASG-Profile"
  role = aws_iam_role.asg_role.name
}

resource "aws_iam_role" "asg_role" {
  name = "${var.app_name}-ASG-Role"
  
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY

  tags = merge(
    var.additional_tags,
    {
       Name = "${var.app_name}-ASG-Role"
    },
  )
}

# Attach ssm policy

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.asg_role.name
}
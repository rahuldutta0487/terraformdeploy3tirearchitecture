resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Allow traffic from web tier to app tier"
  vpc_id      = var.vpc_id

  ingress {
    description     = "App traffic from web tier"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [var.web_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-app-sg"
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "${var.project_name}-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name != "" ? var.key_name : null

  network_interfaces {
    security_groups             = [aws_security_group.app.id]
    associate_public_ip_address = false
  }

  user_data = base64encode(<<-EOF
                #!/bin/bash
                yum update -y
                yum install -y python3
                cat <<APPHTML > /home/ec2-user/app.txt
                App tier instance running in private subnet.
                APPHTML
                EOF
  )
}

resource "aws_autoscaling_group" "app" {
  name                      = "${var.project_name}-app-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 120

  tag {
    key                 = "Name"
    value               = "${var.project_name}-app-asg"
    propagate_at_launch = true
  }
}

data "aws_instances" "app" {
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.app.name]
  }

  depends_on = [aws_autoscaling_group.app]
}

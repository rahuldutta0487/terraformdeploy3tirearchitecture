resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Allow traffic from ALB to web tier"
  vpc_id      = var.vpc_id

  ingress {
    description     = "App port from ALB"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  dynamic "ingress" {
    for_each = var.ssh_allowed_cidrs
    content {
      description = "SSH access"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}

resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-web-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name != "" ? var.key_name : null

  network_interfaces {
    security_groups             = [aws_security_group.web.id]
    associate_public_ip_address = true
  }

     user_data = base64encode(<<-EOF
 #!/bin/bash
 dnf update -y
 dnf install -y nodejs git
 npm install -g pm2
 
 cd /home/ec2-user
 
 rm -rf medicare-simple-js
 
 git clone https://github.com/rahuldutta0487/medicare-simple-js.git
 
 cd medicare-simple-js
 
 sed -i 's/const PORT = 4000;/const PORT = 5000;/g' app.js
 
 npm install
 
 PORT=5000 pm2 start app.js --name medicare
 
 pm2 startup systemd -u ec2-user --hp /home/ec2-user
 pm2 save
 
 EOF
 )
}

resource "aws_autoscaling_group" "web" {
  name                      = "${var.project_name}-web-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns         = [var.target_group_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web-asg"
    propagate_at_launch = true
  }
}

data "aws_instances" "web" {
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-web-asg"]
  }

  depends_on = [aws_autoscaling_group.web]
}
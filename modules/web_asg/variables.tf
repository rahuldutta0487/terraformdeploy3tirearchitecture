variable "project_name" {
  description = "Base name used for web resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the web tier"
  type        = string
}

variable "alb_sg_id" {
  description = "ALB security group ID for web ingress"
  type        = string
}

variable "subnet_ids" {
  description = "Public subnet IDs for the web ASG"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for web instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the web tier"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "List of CIDR blocks allowed SSH access to web instances"
  type        = list(string)
  default     = []
}

variable "target_group_arn" {
  description = "ALB target group ARN for the web tier"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum web ASG size"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired web ASG size"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum web ASG size"
  type        = number
}

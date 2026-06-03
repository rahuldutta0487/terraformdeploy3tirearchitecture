variable "project_name" {
  description = "Base name used for app resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the app tier"
  type        = string
}

variable "web_sg_id" {
  description = "Web tier security group ID"
  type        = string
}

variable "subnet_ids" {
  description = "Private app subnet IDs for the app ASG"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for app instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the app tier"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum app ASG size"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired app ASG size"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum app ASG size"
  type        = number
}

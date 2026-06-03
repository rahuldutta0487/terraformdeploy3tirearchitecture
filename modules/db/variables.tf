variable "project_name" {
  description = "Base name used for database resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the database tier"
  type        = string
}

variable "app_sg_id" {
  description = "App tier security group ID allowed to access the DB"
  type        = string
}

variable "db_subnet_ids" {
  description = "Private DB subnet IDs"
  type        = list(string)
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_name" {
  description = "RDS database name"
  type        = string
}

variable "username" {
  description = "RDS master username"
  type        = string
}

variable "password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

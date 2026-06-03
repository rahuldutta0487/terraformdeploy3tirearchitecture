variable "project_name" {
  description = "Base name used for routing resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for routing"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID for public routing"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for route association"
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "App subnet IDs for private routing"
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "DB subnet IDs for private routing"
  type        = list(string)
}

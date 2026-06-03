variable "project_name" {
  description = "Base name used for subnet resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for creating subnets"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for app subnets"
  type        = list(string)
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks for db subnets"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region for the 3-tier deployment"
  type        = string
}

variable "aws_profile" {
  description = "Optional AWS CLI profile name to use for provider authentication"
  type        = string
  default     = ""
}

variable "aws_shared_credentials_file" {
  description = "Optional path to AWS shared credentials file (e.g., ~/.aws/credentials)"
  type        = string
  default     = ""
}

variable "project" {
  description = "Project-level settings"
  type = object({
    name = string
  })
}

variable "network" {
  description = "Network configuration for the 3-tier deployment"
  type = object({
    vpc = object({
      cidr = string
    })
    availability_zones = list(string)
    subnets = object({
      public = list(string)
      app    = list(string)
      db     = list(string)
    })
  })
}

variable "web_asg" {
  description = "Web tier autoscaling group configuration"
  type = object({
    instance_type     = string
    key_name          = string
    ssh_allowed_cidrs = list(string)
    min_size          = number
    desired_capacity  = number
    max_size          = number
  })
}

variable "app_asg" {
  description = "App tier autoscaling group configuration"
  type = object({
    instance_type    = string
    key_name         = string
    min_size         = number
    desired_capacity = number
    max_size         = number
  })
}

variable "db" {
  description = "Database tier configuration"
  type = object({
    instance_class = string
    name           = string
    username       = string
    password       = string
  })
}

variable "project" {
  description = "Project-level settings for network resources"
  type = object({
    name = string
  })
}

variable "network" {
  description = "Network settings for the 3-tier architecture"
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

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "URL of the public Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "asg_name" {
  description = "Web tier autoscaling group name"
  value       = module.web_asg.autoscaling_group_name
}

output "db_endpoint" {
  description = "RDS MySQL endpoint"
  value       = module.db.db_endpoint
}

output "db_instance_id" {
  description = "RDS MySQL instance id"
  value       = module.db.db_instance_id
}

output "db_port" {
  description = "RDS MySQL port"
  value       = module.db.db_port
}

output "eip_address" {
  description = "Elastic IP address used by the NAT gateway"
  value       = module.network.eip_address
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = module.network.nat_gateway_id
}

output "private_instance_ids" {
  description = "App tier instance IDs"
  value       = join(", ", module.app_asg.instance_ids)
}

output "private_instance_private_ips" {
  description = "App tier private instance IPs"
  value       = join(", ", module.app_asg.private_ips)
}

output "private_subnet_ids" {
  description = "Private app subnet IDs"
  value       = join(", ", module.network.app_subnet_ids)
}

output "public_instance_ids" {
  description = "Web tier instance IDs"
  value       = join(", ", module.web_asg.instance_ids)
}

output "public_instance_public_ips" {
  description = "Web tier public instance IPs"
  value       = join(", ", module.web_asg.public_ips)
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = join(", ", module.network.public_subnet_ids)
}

output "target_group_arn" {
  description = "ALB target group ARN"
  value       = module.alb.target_group_arn
}

output "vpc_id" {
  description = "VPC ID for the 3-tier architecture"
  value       = module.network.vpc_id
}

output "security_group_id" {
  value = aws_security_group.web.id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.web.name
}

output "instance_ids" {
  value = sort(data.aws_instances.web.ids)
}

output "public_ips" {
  value = sort(data.aws_instances.web.public_ips)
}

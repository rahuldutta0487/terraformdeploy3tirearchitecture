output "security_group_id" {
  value = aws_security_group.app.id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.app.name
}

output "instance_ids" {
  value = sort(data.aws_instances.app.ids)
}

output "private_ips" {
  value = sort(data.aws_instances.app.private_ips)
}

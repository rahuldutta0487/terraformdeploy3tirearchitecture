output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.mysql.id
}

output "db_port" {
  value = aws_db_instance.mysql.port
}

output "db_security_group_id" {
  value = aws_security_group.db.id
}

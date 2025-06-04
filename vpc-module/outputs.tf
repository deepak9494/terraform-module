output "app_subnet_ids" {
  description = "List of app subnet IDs"
  value       = aws_subnet.app[*].id
}

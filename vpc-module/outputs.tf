output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.eks-demo-cluster.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "app_subnet_ids" {
  description = "List of app/private subnet IDs"
  value       = aws_subnet.app[*].id
}

output "db_subnet_ids" {
  description = "List of database subnet IDs"
  value       = aws_subnet.db[*].id
}

output "public_route_table_ids" {
  description = "Public route table IDs"
  value       = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "Private route table IDs"
  value       = aws_route_table.private[*].id
}

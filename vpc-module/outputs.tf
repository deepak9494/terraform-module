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
  value = [aws_route_table.public_rt.id]
}

output "private_route_table_ids" {
  value = [
    aws_route_table.rt_app_1a.id,
    aws_route_table.rt_app_1b.id,
    aws_route_table.rt_db_1a.id,
    aws_route_table.rt_db_1b.id
  ]
}

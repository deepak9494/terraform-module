# Public Subnets
variable "public_subnet_azs" {
  description = "Availability Zones for public subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "public_subnet_names" {
  description = "Names for public subnets"
  type        = list(string)
}

# App Subnets
variable "app_subnet_azs" {
  description = "Availability Zones for app subnets"
  type        = list(string)
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for app subnets"
  type        = list(string)
}

variable "app_subnet_names" {
  description = "Names for app subnets"
  type        = list(string)
}

# DB Subnets
variable "db_subnet_azs" {
  description = "Availability Zones for db subnets"
  type        = list(string)
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks for db subnets"
  type        = list(string)
}

variable "db_subnet_names" {
  description = "Names for db subnets"
  type        = list(string)
}

# Optional (can also be removed if unused in logic)
variable "private_route_table_names" {
  description = "Route table names for private subnets (if needed)"
  type        = list(string)
}

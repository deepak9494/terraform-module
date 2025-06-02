resource "aws_vpc" "eks-demo-cluster" {
  cidr_block = "10.0.0.0/16"
   tags = {
    Name = "eks-demo-cluster"
  }
}
# Create Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.eks-demo-cluster.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.public_subnet_azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_names[count.index]
  }
}
# Private Subnets
# App Subnets
resource "aws_subnet" "app" {
  count             = length(var.app_subnet_cidrs)
  vpc_id            = aws_vpc.eks-demo-cluster.id
  cidr_block        = var.app_subnet_cidrs[count.index]
  availability_zone = var.app_subnet_azs[count.index]

  tags = {
    Name = var.app_subnet_names[count.index]
  }
}

# DB Subnets
resource "aws_subnet" "db" {
  count             = length(var.db_subnet_cidrs)
  vpc_id            = aws_vpc.eks-demo-cluster.id
  cidr_block        = var.db_subnet_cidrs[count.index]
  availability_zone = var.db_subnet_azs[count.index]

  tags = {
    Name = var.db_subnet_names[count.index]
  }
}
# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks-demo-cluster.id

  tags = {
    Name = "igw-public"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
}

# NAT Gateway in public subnet 1a
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks-demo-cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "demo-public-rt"
  }
}

# Associate public route table with both web subnets
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public[1].id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Tables for App and DB Subnets
resource "aws_route_table" "rt_app_1a" {
  vpc_id = aws_vpc.eks-demo-cluster.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-app-1a"
  }
}

resource "aws_route_table" "rt_app_1b" {
  vpc_id = aws_vpc.eks-demo-cluster.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-app-1b"
  }
}

resource "aws_route_table" "rt_db_1a" {
  vpc_id = aws_vpc.eks-demo-cluster.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-db-1a"
  }
}

resource "aws_route_table" "rt_db_1b" {
  vpc_id = aws_vpc.eks-demo-cluster.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-db-1b"
  }
}

# Associate route tables with respective subnets
resource "aws_route_table_association" "app_1a" {
  subnet_id      = aws_subnet.app[0].id
  route_table_id = aws_route_table.rt_app_1a.id
}

resource "aws_route_table_association" "app_1b" {
  subnet_id      = aws_subnet.app[1].id
  route_table_id = aws_route_table.rt_app_1b.id
}

resource "aws_route_table_association" "db_1a" {
  subnet_id      = aws_subnet.db[0].id
  route_table_id = aws_route_table.rt_db_1a.id
}

resource "aws_route_table_association" "db_1b" {
  subnet_id      = aws_subnet.db[1].id
  route_table_id = aws_route_table.rt_db_1b.id
}

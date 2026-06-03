resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]
  tags = {
    Name = "${var.project_name}-nat"
  }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "app" {
  count          = length(var.app_subnet_ids)
  subnet_id      = var.app_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnet_ids)
  subnet_id      = var.db_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}

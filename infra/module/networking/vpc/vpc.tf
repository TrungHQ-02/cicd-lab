resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(var.tags, {
    Name = "${local.prefix_name}-vpc"
  })
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.tags, {
    Name = "${local.prefix_name}-internet-gw"
  })
}

resource "aws_eip" "elastic_ip" {
  # domain = "vpc"
  tags = merge(var.tags, {
    Name = "${local.prefix_name}-eip"
  })
  depends_on = [aws_internet_gateway.ig]
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id         = aws_subnet.subnet[var.nat_subnet_key].id
  allocation_id     = aws_eip.elastic_ip.id
  depends_on        = [aws_internet_gateway.ig]
  connectivity_type = var.connectivity_type

  tags = merge(var.tags, {
    Name = "${local.prefix_name}-nat-gw"
  })
}

resource "aws_subnet" "subnet" {
  for_each                = var.map_subnet_objects
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(var.tags, {
    Name = "${local.prefix_name}-${each.value.name}"
  })
}

resource "aws_route_table" "route_table" {
  for_each = var.map_rt_objects
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block = each.value.cidr_block
    gateway_id = each.value.is_public ? aws_internet_gateway.ig.id : aws_nat_gateway.nat_gateway.id
  }

  tags = merge(var.tags, {
    Name = "${local.prefix_name}-rtb"
  })
}

resource "aws_route_table_association" "route_table_association" {
  for_each       = var.map_subnet_objects
  route_table_id = aws_route_table.route_table[each.value.route_table_key].id
  subnet_id      = aws_subnet.subnet[each.key].id
}


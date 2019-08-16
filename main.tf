# ---------------------------------------------------------------------------------------------------------------------
# PROVIDER
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  profile = var.profile
  region  = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Virtual Private Network
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block # The CIDR block for the VPC.
  enable_dns_support   = true               # A boolean flag to enable/disable DNS support in the VPC.
  enable_dns_hostnames = true               # A boolean flag to enable/disable DNS hostnames in the VPC.
  tags = {
    Name = "${var.name_preffix}-vpc"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Internet Gateway
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name_preffix}-internet-gw"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Subnets - Public
# ---------------------------------------------------------------------------------------------------------------------
# Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.availability_zones, count.index)
  cidr_block              = element(var.public_subnets_cidrs_per_availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_preffix}-public-net-${element(var.availability_zones, count.index)}"
  }
}

# Elastic IPs for NAT
resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)
  vpc   = true
  tags = {
    Name = "${var.name_preffix}-nat-eip-${element(var.availability_zones, count.index)}"
  }
}

# NAT Gateways
resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.availability_zones)
  depends_on    = [aws_internet_gateway.internet_gw]
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
  tags = {
    Name = "${var.name_preffix}-nat-gw-${element(var.availability_zones, count.index)}"
  }
}

# Public route table
resource "aws_route_table" "public_subnets_route_table" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name_preffix}-public-rt-${element(var.availability_zones, count.index)}"
  }
}

# Public route to access internet
resource "aws_route" "public_internet_route" {
  count      = length(var.availability_zones)
  depends_on = [
    aws_internet_gateway.internet_gw,
    aws_route_table.public_subnets_route_table,
  ]
  route_table_id         = element(aws_route_table.public_subnets_route_table.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw.id
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "public_internet_route_table_associations" {
  count          = length(var.public_subnets_cidrs_per_availability_zone)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_subnets_route_table.*.id, count.index)
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Subnets - Private
# ---------------------------------------------------------------------------------------------------------------------
# Subnets
resource "aws_subnet" "private_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.availability_zones, count.index)
  cidr_block              = element(var.private_subnets_cidrs_per_availability_zone, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.name_preffix}-private-net-${element(var.availability_zones, count.index)}"
  }
}

# Private route table
resource "aws_route_table" "private_subnets_route_table" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name_preffix}-private-rt-${element(var.availability_zones, count.index)}"
  }
}

# Private route to access internet
resource "aws_route" "private_internet_route" {
  count      = length(var.availability_zones)
  depends_on = [
    aws_internet_gateway.internet_gw,
    aws_route_table.private_subnets_route_table,
  ]
  route_table_id         = element(aws_route_table.private_subnets_route_table.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gw.*.id, count.index)
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "private_internet_route_table_associations" {
  count     = length(var.private_subnets_cidrs_per_availability_zone)
  subnet_id = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(
    aws_route_table.private_subnets_route_table.*.id,
    count.index,
  )
}

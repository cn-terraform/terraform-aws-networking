#------------------------------------------------------------------------------
# Public Subnets
#------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

  vpc_id                                         = aws_vpc.vpc.id
  enable_resource_name_dns_aaaa_record_on_launch = var.public_subnets_enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = var.public_subnets_enable_resource_name_dns_a_record_on_launch
  map_public_ip_on_launch                        = var.map_public_ip_on_launch
  tags = merge(
    var.additional_tags,
    {
      Name = each.key
    },
    var.public_subnets_additional_tags
  )
}

#------------------------------------------------------------------------------
# NAT
#------------------------------------------------------------------------------
# Elastic IPs for NAT
resource "aws_eip" "nat" {
  for_each = var.single_nat ? { keys(aws_subnet.public)[0] = values(aws_subnet.public)[0] } : aws_subnet.public

  domain = "vpc"

  tags = merge(
    var.additional_tags,
    {
      Name = "nat-eip-${each.key}"
    },
  )
}

# NAT gateways
resource "aws_nat_gateway" "nat" {
  for_each = var.single_nat ? { keys(aws_subnet.public)[0] = values(aws_subnet.public)[0] } : aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = merge(
    var.additional_tags,
    {
      Name = "nat-gw-${each.key}"
    },
  )
}

#------------------------------------------------------------------------------
# Route tables
#------------------------------------------------------------------------------

# Route table
resource "aws_route_table" "public" {
  for_each = aws_subnet.public

  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.additional_tags,
    {
      Name = "public-rt-${each.key}"
    },
  )
}

# Route to access internet
resource "aws_route" "public_internet" {
  for_each = aws_route_table.public

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw.id
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[each.key].id
}

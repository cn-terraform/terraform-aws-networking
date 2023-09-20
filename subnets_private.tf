#------------------------------------------------------------------------------
# Private Subnets
#------------------------------------------------------------------------------

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

  vpc_id                                         = aws_vpc.vpc.id
  enable_resource_name_dns_aaaa_record_on_launch = var.private_subnets_enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = var.private_subnets_enable_resource_name_dns_a_record_on_launch
  map_public_ip_on_launch                        = false
  tags = merge(
    var.additional_tags,
    {
      Name = each.key
    },
    var.private_subnets_additional_tags
  )
}

#------------------------------------------------------------------------------
# Route tables
#------------------------------------------------------------------------------

# Route table
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.additional_tags,
    {
      Name = "private-rt-${each.key}"
    },
  )
}

# Route to access internet
resource "aws_route" "private_internet_route" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"

  # Zipmap to create map between public and private ids
  nat_gateway_id = aws_nat_gateway.nat[zipmap(keys(aws_subnet.private), keys(aws_subnet.public))[each.key]].id
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

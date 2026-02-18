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

##########################
# Private subnets flow log
##########################
resource "aws_flow_log" "private_subnet_flow_log" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log
  for_each = { for k, v in var.private_subnets : k => v if v.enable_flow_log }

  deliver_cross_account_role = var.flow_log_deliver_cross_account_role
  iam_role_arn               = var.flow_log_iam_role_arn
  log_destination_type       = var.flow_log_log_destination_type
  log_destination            = var.flow_log_log_destination
  log_format                 = var.flow_log_log_format
  max_aggregation_interval   = var.flow_log_max_aggregation_interval
  subnet_id                  = aws_subnet.private[each.key].id
  traffic_type               = var.flow_log_traffic_type

  destination_options {
    file_format                = var.flow_log_destination_options.file_format
    hive_compatible_partitions = var.flow_log_destination_options.hive_compatible_partitions
    per_hour_partition         = var.flow_log_destination_options.per_hour_partition
  }

  tags = merge(
    {
      Name = format("%s-private-subnet-%s-flow-log", var.name_prefix, each.key)
    },
    var.additional_tags,
    var.flow_log_additional_tags,
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
      Name = format("private-rt-%s", each.key)
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

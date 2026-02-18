################
# Public Subnets
################
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

##########################
# Public subnets flow logs
##########################
resource "aws_flow_log" "public_subnet_flow_log" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log
  for_each = { for k, v in var.public_subnets : k => v if v.enable_flow_log }

  deliver_cross_account_role = var.flow_log_deliver_cross_account_role
  iam_role_arn               = var.flow_log_iam_role_arn
  log_destination_type       = var.flow_log_log_destination_type
  log_destination            = var.flow_log_log_destination
  log_format                 = var.flow_log_log_format
  max_aggregation_interval   = var.flow_log_max_aggregation_interval
  subnet_id                  = aws_subnet.public[each.key].id
  traffic_type               = var.flow_log_traffic_type

  destination_options {
    file_format                = var.flow_log_destination_options.file_format
    hive_compatible_partitions = var.flow_log_destination_options.hive_compatible_partitions
    per_hour_partition         = var.flow_log_destination_options.per_hour_partition
  }

  tags = merge(
    {
      Name = format("%s-public-subnet-%s-flow-log", var.name_prefix, each.key)
    },
    var.additional_tags,
    var.flow_log_additional_tags,
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
      Name = format("nat-eip-%s", each.key)
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
      Name = format("nat-gw-%s", each.key)
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
      Name = format("public-rt-%s", each.key)
    },
  )
}

# Route to access internet
resource "aws_route" "public_internet" {
  for_each = aws_route_table.public

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw[0].id
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[each.key].id
}

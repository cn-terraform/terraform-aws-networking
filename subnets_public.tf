################
# Public Subnets
################
resource "aws_subnet" "public" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
  for_each = var.public_subnets

  vpc_id = aws_vpc.vpc.id

  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  availability_zone               = each.value.availability_zone
  cidr_block                      = each.value.cidr_block
  # customer_owned_ipv4_pool        = each.value.customer_owned_ipv4_pool
  ipv6_cidr_block     = each.value.ipv6_cidr_block
  ipv6_native         = each.value.ipv6_native
  ipv4_ipam_pool_id   = each.value.ipv4_ipam_pool_id
  ipv4_netmask_length = each.value.ipv4_netmask_length
  ipv6_ipam_pool_id   = each.value.ipv6_ipam_pool_id
  ipv6_netmask_length = each.value.ipv6_netmask_length
  # map_customer_owned_ip_on_launch = each.value.map_customer_owned_ip_on_launch
  outpost_arn = each.value.outpost_arn

  enable_dns64                                   = var.public_subnets_enable_dns64
  enable_resource_name_dns_aaaa_record_on_launch = var.public_subnets_enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = var.public_subnets_enable_resource_name_dns_a_record_on_launch
  map_public_ip_on_launch                        = var.public_subnets_map_public_ip_on_launch
  private_dns_hostname_type_on_launch            = var.public_subnets_private_dns_hostname_type_on_launch

  tags = merge(
    var.additional_tags,
    var.public_subnets_additional_tags,
    {
      Name = format("%s-%s", var.name_prefix, each.key)
    }
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

#############
# NAT Gateway
#############
# Elastic IPs
resource "aws_eip" "nat" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
  for_each = local.nat_gateway_availability_zones

  domain = "vpc"

  tags = merge(
    var.additional_tags,
    {
      Name = format("%s-nat-eip-%s", var.name_prefix, each.key)
    },
  )
}

# Regional NAT gateway
resource "aws_nat_gateway" "regional" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
  count = var.nat_gateway_availability_mode == "regional" ? 1 : 0

  availability_mode = "regional"
  connectivity_type = var.nat_gateway_connectivity_type
  vpc_id            = aws_vpc.vpc.id

  dynamic "availability_zone_address" {
    for_each = local.nat_gateway_availability_zones
    content {
      allocation_ids    = [aws_eip.nat[availability_zone_address.key].id]
      availability_zone = availability_zone_address.value
    }
  }

  tags = merge(
    var.additional_tags,
    var.nat_gateway_additional_tags,
    {
      Name = format("%s-nat-gw", var.name_prefix)
    }
  )
}

# Zonal NAT gateways
resource "aws_nat_gateway" "zonal" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
  for_each = var.nat_gateway_availability_mode == "zonal" ? local.nat_gateway_availability_zones : {}

  allocation_id     = aws_eip.nat[each.key].id
  availability_mode = "zonal"
  connectivity_type = var.nat_gateway_connectivity_type
  subnet_id         = aws_subnet.public[each.key].id

  tags = merge(
    var.additional_tags,
    var.nat_gateway_additional_tags,
    {
      Name = format("%s-nat-gw-%s", var.name_prefix, each.key)
    }
  )
}

##############
# Route tables
##############
resource "aws_route_table" "public" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
  for_each = aws_subnet.public

  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.additional_tags,
    {
      Name = format("%s-public-rt-%s", var.name_prefix, each.key)
    },
  )
}

# Route to access internet
resource "aws_route" "public_internet" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
  for_each = aws_route_table.public

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw[0].id
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "public" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[each.key].id
}

###################################
# AWS Virtual Private Network (VPC)
###################################
resource "aws_vpc" "vpc" { # https://registry.terraform.io/providers/-/aws/latest/docs/resources/vpc
  assign_generated_ipv6_cidr_block     = var.vpc_assign_generated_ipv6_cidr_block
  cidr_block                           = var.vpc_cidr_block
  instance_tenancy                     = var.vpc_instance_tenancy
  ipv4_ipam_pool_id                    = var.vpc_ipv4_ipam_pool_id
  ipv4_netmask_length                  = var.vpc_ipv4_netmask_length
  ipv6_cidr_block                      = var.vpc_ipv6_cidr_block
  ipv6_cidr_block_network_border_group = var.vpc_ipv6_cidr_block_network_border_group
  ipv6_ipam_pool_id                    = var.vpc_ipv6_ipam_pool_id
  ipv6_netmask_length                  = var.vpc_ipv6_netmask_length
  enable_dns_hostnames                 = var.vpc_enable_dns_hostnames
  enable_dns_support                   = var.vpc_enable_dns_support
  enable_network_address_usage_metrics = var.vpc_enable_network_address_usage_metrics

  tags = merge(
    {
      Name = var.name_prefix
    },
    var.additional_tags,
    var.vpc_additional_tags,
  )
}

######################
# AWS Internet Gateway
######################
resource "aws_internet_gateway" "internet_gw" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
  count = var.vpc_create_internet_gateway ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = var.name_prefix
    },
    var.additional_tags,
    var.vpc_additional_tags,
  )
}

###############
# VPC Flow Logs
###############
resource "aws_flow_log" "vpc_flow_log" { # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log
  count = var.vpc_enable_flow_log ? 1 : 0

  deliver_cross_account_role = var.flow_log_deliver_cross_account_role
  iam_role_arn               = var.flow_log_iam_role_arn
  log_destination_type       = var.flow_log_log_destination_type
  log_destination            = var.flow_log_log_destination
  log_format                 = var.flow_log_log_format
  max_aggregation_interval   = var.flow_log_max_aggregation_interval
  traffic_type               = var.flow_log_traffic_type
  vpc_id                     = aws_vpc.vpc.id
  # regional_nat_gateway_id - (Optional) Regional NAT Gateway ID to attach to.
  # subnet_id - (Optional) Subnet ID to attach to.

  destination_options {
    file_format                = var.flow_log_destination_options.file_format
    hive_compatible_partitions = var.flow_log_destination_options.hive_compatible_partitions
    per_hour_partition         = var.flow_log_destination_options.per_hour_partition
  }

  tags = merge(
    {
      Name = "${var.name_prefix}-vpc-flow-log"
    },
    var.additional_tags,
    var.flow_log_additional_tags,
  )
}

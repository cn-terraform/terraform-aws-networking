#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------

# VPC
resource "aws_vpc" "vpc" {

  assign_generated_ipv6_cidr_block     = var.vpc_assign_generated_ipv6_cidr_block
  cidr_block                           = var.vpc_cidr_block
  enable_dns_support                   = var.vpc_enable_dns_support
  enable_network_address_usage_metrics = var.vpc_enable_network_address_usage_metrics
  enable_dns_hostnames                 = var.vpc_enable_dns_hostnames
  instance_tenancy                     = var.vpc_instance_tenancy
  ipv4_ipam_pool_id                    = var.vpc_ipv4_ipam_pool_id
  ipv4_netmask_length                  = var.vpc_ipv4_netmask_length
  ipv6_cidr_block                      = var.vpc_ipv6_cidr_block
  ipv6_cidr_block_network_border_group = var.vpc_ipv6_cidr_block_network_border_group
  ipv6_ipam_pool_id                    = var.vpc_ipv6_ipam_pool_id
  ipv6_netmask_length                  = var.vpc_ipv6_netmask_length

  tags = merge(
    {
      Name = var.name_prefix
    },
    var.additional_tags,
    var.vpc_additional_tags,
  )
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = var.name_prefix
    },
    var.additional_tags,
    var.vpc_additional_tags,
  )
}

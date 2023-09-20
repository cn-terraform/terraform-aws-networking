#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------
output "arn" {
  description = "Amazon Resource Name (ARN) of VPC"
  value       = aws_vpc.vpc.arn
}

output "id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = aws_vpc.vpc.instance_tenancy
}

output "enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = aws_vpc.vpc.enable_dns_support
}

output "enable_network_address_usage_metrics" {
  description = "Whether Network Address Usage metrics are enabled for the VPC"
  value       = aws_vpc.vpc.enable_network_address_usage_metrics
}

output "enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = aws_vpc.vpc.enable_dns_hostnames
}

output "main_route_table_id" {
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association."
  value       = aws_vpc.vpc.main_route_table_id
}

output "default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value       = aws_vpc.vpc.default_network_acl_id
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = aws_vpc.vpc.default_security_group_id
}

output "default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value       = aws_vpc.vpc.default_route_table_id
}

output "ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block."
  value       = aws_vpc.vpc.ipv6_association_id
}

output "ipv6_cidr_block_network_border_group" {
  description = "The Network Border Group Zone name"
  value       = aws_vpc.vpc.ipv6_cidr_block_network_border_group
}

output "owner_id" {
  description = "The ID of the AWS account that owns the VPC."
  value       = aws_vpc.vpc.owner_id
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_vpc.vpc.tags_all
}

# #------------------------------------------------------------------------------
# # AWS Internet Gateway
# #------------------------------------------------------------------------------
# output "internet_gateway_id" {
#   description = "ID of the generated Internet Gateway"
#   value       = aws_internet_gateway.internet_gw.id
# }

# #------------------------------------------------------------------------------
# # AWS Subnets - Public
# #------------------------------------------------------------------------------
# output "public_subnets_ids" {
#   description = "List with the Public Subnets IDs"
#   value       = aws_subnet.public_subnets.*.id
# }

# output "public_subnets_route_table_id" {
#   description = "ID of the Route Tables used on Public networks"
#   value       = aws_route_table.public_subnets_route_table.*.id
# }

# output "nat_gw_ids" {
#   description = "List with the IDs of the NAT Gateways created on public subnets to provide internet to private subnets"
#   value       = aws_nat_gateway.nat_gw.*.id
# }

# #------------------------------------------------------------------------------
# # AWS Subnets - Private
# #------------------------------------------------------------------------------
# output "private_subnets_ids" {
#   description = "List with the Private Subnets IDs"
#   value       = aws_subnet.private_subnets.*.id
# }

# output "private_subnets_route_table_id" {
#   description = "ID of the Route Table used on Private networks"
#   value       = aws_route_table.private_subnets_route_table.*.id
# }

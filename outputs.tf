###################################
# AWS Virtual Private Network (VPC)
###################################
output "vpc" {
  description = "Values from the generated VPC."
  value       = aws_vpc.vpc
}

######################
# AWS Internet Gateway
######################
output "internet_gateway_id" {
  description = "Values from the generated Internet Gateway in case it was created."
  value       = var.vpc_create_internet_gateway ? aws_internet_gateway.internet_gw[0] : null
}

######################
# AWS Subnets - Public
######################
output "public_subnets" {
  description = "Values from the generated public subnets"
  value       = aws_subnet.public
}

# output "public_subnets_route_tables" {
#   description = "Values from the generated route tables for the public subnets"
#   value       = aws_route_table.public
# }

# output "nat_gws" {
#   description = "Values from the generated NAT gateways"
#   value       = var.nat_gateway_availability_mode == "regional" ? aws_nat_gateway.regional[0] : aws_nat_gateway.zonal
# }

#######################
# AWS Subnets - Private
#######################
output "private_subnets" {
  description = "Values from the generated private subnets"
  value       = aws_subnet.private
}

# output "private_subnets_route_tables" {
#   description = "Values from the generated route tables for the private subnets"
#   value       = aws_route_table.private
# }

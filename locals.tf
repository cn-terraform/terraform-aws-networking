locals {
  public_subnets_azs             = { for k, v in var.public_subnets : k => v.availability_zone }
  nat_gateway_availability_zones = var.nat_gateway_availability_zones == null ? local.public_subnets_azs : { for k, v in local.public_subnets_azs : k => v if contains(var.nat_gateway_availability_zones, v) }
}

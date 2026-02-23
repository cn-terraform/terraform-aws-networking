locals {
  public_subnets_azs = { for k, v in var.public_subnets : k => v.availability_zone }

  nat_gateway_availability_zones = var.nat_gateway_availability_zones == null ? local.public_subnets_azs : { for k, v in local.public_subnets_azs : k => v if contains(var.nat_gateway_availability_zones, v) }

  private_subnet_to_nat_routes = var.nat_gateway_availability_mode == "zonal" ? { for k, _ in local.nat_gateway_availability_zones : k => contains(keys(var.private_subnets, k)) ? k : keys(var.private_subnets)[0] } : {}
}

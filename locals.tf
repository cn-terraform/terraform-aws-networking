locals {
  public_subnets_azs = { for k, v in var.public_subnets : k => v.availability_zone }

  nat_gateway_availability_zones = var.nat_gateway_availability_zones == null ? local.public_subnets_azs : { for k, v in local.public_subnets_azs : k => v if contains(var.nat_gateway_availability_zones, v) }

  sorted_public_subnet_keys  = sort(keys(var.public_subnets))
  sorted_private_subnet_keys = sort(keys(var.private_subnets))

  # For each private subnet configured, collect all public subnets that will be deployed in the same AZ
  private_to_public_route_candidates = {
    for private_subnet_key in local.sorted_private_subnet_keys : private_subnet_key => [for public_subnet_key, public_subnet_value in var.public_subnets : public_subnet_key if public_subnet_value.availability_zone == var.private_subnets[private_subnet_key].availability_zone]
  }

  # Pick a candidate for a route from a private subnet to a NAT Gw in the same AZ or fallback to round-robin if none
  private_to_public_routes = {
    for i, private_subnet_key in local.sorted_private_subnet_keys : private_subnet_key => length(local.private_to_public_route_candidates[private_subnet_key]) > 0 ? local.private_to_public_route_candidates[private_subnet_key][i % length(local.private_to_public_route_candidates[private_subnet_key])] : local.sorted_public_subnet_keys[i % length(local.sorted_public_subnet_keys)]
  }
}

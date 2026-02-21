locals {
  nat_gateway_availability_zones = var.nat_gateway_availability_mode == "zonal" ? var.nat_gateway_availability_zones : [for subnet in aws_subnet.public : subnet.availability_zone if contains(var.nat_gateway_availability_zones, subnet.availability_zone)]
}

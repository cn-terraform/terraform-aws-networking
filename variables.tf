# ---------------------------------------------------------------------------------------------------------------------
# Misc
# ---------------------------------------------------------------------------------------------------------------------
variable "name_preffix" {
  description = "Name preffix for resources on AWS"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Virtual Private Network
# ---------------------------------------------------------------------------------------------------------------------
variable "vpc_cidr_block" {
  description = "AWS VPC CIDR Block"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Subnets
# ---------------------------------------------------------------------------------------------------------------------
variable "availability_zones" {
  type        = list
  description = "List of availability zones to be used by subnets"
}

variable "public_subnets_cidrs_per_availability_zone" {
  type        = list
  description = "List of CIDRs to use on each availability zone for public subnets"
}

variable "private_subnets_cidrs_per_availability_zone" {
  type        = list
  description = "List of CIDRs to use on each availability zone for private subnets"
}

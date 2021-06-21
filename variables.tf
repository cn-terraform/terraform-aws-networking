#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS"
}

#------------------------------------------------------------------------------
# AWS Virtual Private Network
#------------------------------------------------------------------------------
variable "vpc_cidr_block" {
  description = "AWS VPC CIDR Block"
}

#------------------------------------------------------------------------------
# AWS Subnets
#------------------------------------------------------------------------------
variable "availability_zones" {
  type        = list(any)
  description = "List of availability zones to be used by subnets"
}

variable "public_subnets_cidrs_per_availability_zone" {
  type        = list(any)
  description = "List of CIDRs to use on each availability zone for public subnets"
}

variable "private_subnets_cidrs_per_availability_zone" {
  type        = list(any)
  description = "List of CIDRs to use on each availability zone for private subnets"
}

variable "single_nat" {
  type        = bool
  default     = false
  description = "enable single NAT Gateway"
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}

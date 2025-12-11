#------------------------------------------------------------------------------
# General settings
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "(Required) The prefix to use for naming resources created in this module."
  type        = string
}

#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------
variable "vpc_cidr_block" {
  type        = string
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4_netmask_length"
  default     = null
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee."
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated"], var.vpc_instance_tenancy)
    error_message = "The vpc_instance_tenancy variable can only be set to one of ${join(", ", ["default", "dedicated"])}"
  }
}

variable "vpc_ipv4_ipam_pool_id" {
  type        = string
  description = "(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization."
  default     = null
}

variable "vpc_ipv4_netmask_length" {
  type        = number
  description = "(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4_ipam_pool_id."
  default     = null
}

variable "vpc_ipv6_cidr_block" {
  type        = string
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using ipv6_netmask_length."
  default     = null
}

variable "vpc_ipv6_ipam_pool_id" {
  type        = string
  description = "(Optional) IPAM Pool ID for a IPv6 pool. Conflicts with assign_generated_ipv6_cidr_block."
  default     = null
}

variable "vpc_ipv6_netmask_length" {
  type        = number
  description = "(Optional) Netmask length to request from IPAM Pool. Conflicts with ipv6_cidr_block. This can be omitted if IPAM pool as a allocation_default_netmask_length set. Valid values are from 44 to 60 in increments of 4."
  default     = null
}

variable "vpc_ipv6_cidr_block_network_border_group" {
  description = "(Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6_cidr_block_network_border_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones."
  type        = string
  default     = null
}

variable "vpc_enable_dns_support" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults to true."
  default     = true
}

variable "vpc_enable_network_address_usage_metrics" {
  type        = bool
  description = "(Optional) Indicates whether Network Address Usage metrics are enabled for your VPC. Defaults to false."
  default     = false
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  default     = false
}

variable "vpc_assign_generated_ipv6_cidr_block" {
  description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false. Conflicts with ipv6_ipam_pool_id"
  type        = bool
  default     = false
}

variable "vpc_additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

#------------------------------------------------------------------------------
# Public Subnets
#------------------------------------------------------------------------------
variable "public_subnets" {
  type = map(object({
    availability_zone = string # Availability Zone for the subnet.
    cidr_block        = string # The IPv4 CIDR block for the subnet.
  }))
  description = "(Optional) Map of objects containing the definition for each public subnet"
  default     = {}
}

variable "public_subnets_enable_resource_name_dns_aaaa_record_on_launch" {
  type        = bool
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false."
  default     = false
}

variable "public_subnets_enable_resource_name_dns_a_record_on_launch" {
  type        = bool
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false."
  default     = false
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  default     = false
}

variable "public_subnets_additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "single_nat" {
  type        = bool
  description = "Use single NAT Gateway"
  default     = false
}

#------------------------------------------------------------------------------
# Private Subnets
#------------------------------------------------------------------------------
variable "private_subnets" {
  type = map(object({
    availability_zone = string # Availability Zone for the subnet.
    cidr_block        = string # The IPv4 CIDR block for the subnet.
  }))
  description = "(Optional) Map of objects containing the definition for each private subnet"
  default     = {}
}

variable "private_subnets_enable_resource_name_dns_aaaa_record_on_launch" {
  type        = bool
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false."
  default     = false
}

variable "private_subnets_enable_resource_name_dns_a_record_on_launch" {
  type        = bool
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false."
  default     = false
}

variable "private_subnets_additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to all the resources. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

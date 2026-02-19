##################
# General settings
##################
variable "name_prefix" {
  description = "(Required) The prefix to use for naming resources created in this module."
  type        = string
}

variable "additional_tags" {
  description = "(Optional) A map of tags to assign to all the resources. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

###################################
# AWS Virtual Private Network (VPC)
###################################
variable "vpc_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4_netmask_length."
  type        = string
  default     = null
}

variable "vpc_assign_generated_ipv6_cidr_block" {
  description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false. Conflicts with ipv6_ipam_pool_id"
  type        = bool
  default     = false
}

variable "vpc_instance_tenancy" {
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee."
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated"], var.vpc_instance_tenancy)
    error_message = "The vpc_instance_tenancy variable can only be set to one of ${join(", ", ["default", "dedicated"])}"
  }
}

variable "vpc_ipv4_ipam_pool_id" {
  description = "(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization."
  type        = string
  default     = null
}

variable "vpc_ipv4_netmask_length" {
  description = "(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4_ipam_pool_id."
  type        = number
  default     = null
}

variable "vpc_ipv6_cidr_block" {
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using ipv6_netmask_length."
  type        = string
  default     = null
}

variable "vpc_ipv6_ipam_pool_id" {
  description = "(Optional) IPAM Pool ID for a IPv6 pool. Conflicts with assign_generated_ipv6_cidr_block."
  type        = string
  default     = null
}

variable "vpc_ipv6_netmask_length" {
  description = "(Optional) Netmask length to request from IPAM Pool. Conflicts with ipv6_cidr_block. This can be omitted if IPAM pool as a allocation_default_netmask_length set. Valid values are from 44 to 60 in increments of 4."
  type        = number
  default     = null
}

variable "vpc_ipv6_cidr_block_network_border_group" {
  description = "(Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6_cidr_block_network_border_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones."
  type        = string
  default     = null
}

variable "vpc_enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
  default     = false
}

variable "vpc_enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults to true."
  type        = bool
  default     = true
}

variable "vpc_enable_network_address_usage_metrics" {
  description = "(Optional) Indicates whether Network Address Usage metrics are enabled for your VPC. Defaults to false."
  type        = bool
  default     = false
}

variable "vpc_additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "vpc_create_internet_gateway" {
  description = "(Optional) Whether to create an Internet Gateway and attach it to the VPC. Default is true."
  type        = bool
  default     = true
}

variable "vpc_enable_flow_log" {
  description = "(Optional) Whether to create a flow log for the VPC. Default is false. If enabled, some of the variables starting with `flow_log` need to be configured."
  type        = bool
  default     = false
}

################
# Public Subnets
################
variable "public_subnets" {
  type = map(object({
    availability_zone               = string                # Availability Zone for the subnet.
    assign_ipv6_address_on_creation = optional(bool, false) # (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false
    cidr_block                      = optional(string)      # The IPv4 CIDR block for the subnet.
    customer_owned_ipv4_pool        = optional(string)      # The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured.
    enable_flow_log                 = optional(bool, false) # (Optional) Whether to create a flow log for the subnet. Default is false. If enabled, some of the variables starting with `flow_log` need to be configured.
    ipv6_cidr_block                 = optional(string)      # The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length. If the existing IPv6 subnet was created with assign_ipv6_address_on_creation = true, changing this value will force resource recreation.
    ipv6_native                     = optional(bool, false) # Indicates whether to create an IPv6-only subnet. Default: false.
    ipv4_ipam_pool_id               = optional(string)      # ID of an IPv4 VPC Resource Planning IPAM Pool. The CIDR of this pool is used to allocate the CIDR for the subnet.
    ipv4_netmask_length             = optional(number)      # Netmask. Requires specifying a ipv4_ipam_pool_id.
    ipv6_ipam_pool_id               = optional(string)      # ID of an IPv6 VPC Resource Planning IPAM Pool. The CIDR of this pool is used to allocate the CIDR for the subnet.
    ipv6_netmask_length             = optional(number)      # Netmask. Requires specifying a ipv6_ipam_pool_id. Valid values are from 44 to 64 in increments of 4.
    map_customer_owned_ip_on_launch = optional(bool, false) # Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true. Default is false.
    outpost_arn                     = optional(string)      # The Amazon Resource Name (ARN) of the Outpost.
  }))
  description = "(Optional) Map of objects containing the definition for each public subnet"
  default     = {}

  # Every subnet must define IPv4
  validation {
    condition = alltrue([
      for _, s in var.public_subnets : (
        s.cidr_block != null ||
        (s.ipv4_ipam_pool_id != null && s.ipv4_netmask_length != null)
      )
    ])
    error_message = "Each public subnet must define either `cidr_block`, or both `ipv4_ipam_pool_id` and `ipv4_netmask_length`."
  }

  # If IPv6 is used, it must be valid
  validation {
    condition = alltrue([
      for _, s in var.public_subnets : (
        !(s.assign_ipv6_address_on_creation || s.ipv6_native) ||
        (
          s.ipv6_cidr_block != null ||
          (s.ipv6_ipam_pool_id != null && s.ipv6_netmask_length != null)
        )
      )
    ])
    error_message = "If IPv6 is requested (`assign_ipv6_address_on_creation` or `ipv6_native`), each subnet must provide either `ipv6_cidr_block`, or both `ipv6_ipam_pool_id` and `ipv6_netmask_length`."
  }

  # Customer-owned IP mapping dependencies
  validation {
    condition = alltrue([
      for _, s in var.public_subnets : (
        !s.map_customer_owned_ip_on_launch ||
        (s.customer_owned_ipv4_pool != null && s.outpost_arn != null)
      )
    ])
    error_message = "If `map_customer_owned_ip_on_launch` is true, then `customer_owned_ipv4_pool` and `outpost_arn` must both be provided."
  }
}

variable "public_subnets_enable_dns64" {
  description = "(Optional) Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. Default: false."
  type        = bool
  default     = false
}

variable "public_subnets_enable_resource_name_dns_aaaa_record_on_launch" {
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false."
  type        = bool
  default     = false
}

variable "public_subnets_enable_resource_name_dns_a_record_on_launch" {
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false."
  type        = bool
  default     = false
}

variable "public_subnets_map_public_ip_on_launch" {
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  type        = bool
  default     = false
}

variable "public_subnets_private_dns_hostname_type_on_launch" {
  description = "(Optional) The type of hostnames to assign to instances in the subnet at launch. For IPv6-only subnets, an instance DNS name must be based on the instance ID. For dual-stack and IPv4-only subnets, you can specify whether DNS names use the instance IPv4 address or the instance ID. Valid values: ip-name, resource-name."
  type        = string
  default     = "ip-name"

  validation {
    condition     = contains(["ip-name", "resource-name"], var.public_subnets_private_dns_hostname_type_on_launch)
    error_message = "Only ip-name or resource-name are valid values for the var.public_subnets_private_dns_hostname_type_on_launch"
  }
}

variable "public_subnets_additional_tags" {
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

##############
# NAT Gateways
##############
variable "single_nat" {
  type        = bool
  description = "Use single NAT Gateway"
  default     = false
}

#################
# Private Subnets
#################
variable "private_subnets" {
  type = map(object({
    availability_zone               = string                # Availability Zone for the subnet.
    assign_ipv6_address_on_creation = optional(bool, false) # (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false
    cidr_block                      = optional(string)      # The IPv4 CIDR block for the subnet.
    customer_owned_ipv4_pool        = optional(string)      # The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured.
    enable_flow_log                 = optional(bool, false) # (Optional) Whether to create a flow log for the subnet. Default is false. If enabled, some of the variables starting with `flow_log` need to be configured.
    ipv6_cidr_block                 = optional(string)      # The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length. If the existing IPv6 subnet was created with assign_ipv6_address_on_creation = true, changing this value will force resource recreation.
    ipv6_native                     = optional(bool, false) # Indicates whether to create an IPv6-only subnet. Default: false.
    ipv4_ipam_pool_id               = optional(string)      # ID of an IPv4 VPC Resource Planning IPAM Pool. The CIDR of this pool is used to allocate the CIDR for the subnet.
    ipv4_netmask_length             = optional(number)      # Netmask. Requires specifying a ipv4_ipam_pool_id.
    ipv6_ipam_pool_id               = optional(string)      # ID of an IPv6 VPC Resource Planning IPAM Pool. The CIDR of this pool is used to allocate the CIDR for the subnet.
    ipv6_netmask_length             = optional(number)      # Netmask. Requires specifying a ipv6_ipam_pool_id. Valid values are from 44 to 64 in increments of 4.
    map_customer_owned_ip_on_launch = optional(bool, false) # Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true. Default is false.
    outpost_arn                     = optional(string)      # The Amazon Resource Name (ARN) of the Outpost.
  }))
  description = "(Optional) Map of objects containing the definition for each private subnet"
  default     = {}

  # Every subnet must define IPv4
  validation {
    condition = alltrue([
      for _, s in var.private_subnets : (
        s.cidr_block != null ||
        (s.ipv4_ipam_pool_id != null && s.ipv4_netmask_length != null)
      )
    ])
    error_message = "Each private subnet must define either `cidr_block`, or both `ipv4_ipam_pool_id` and `ipv4_netmask_length`."
  }

  # If IPv6 is used, it must be valid
  validation {
    condition = alltrue([
      for _, s in var.private_subnets : (
        !(s.assign_ipv6_address_on_creation || s.ipv6_native) ||
        (
          s.ipv6_cidr_block != null ||
          (s.ipv6_ipam_pool_id != null && s.ipv6_netmask_length != null)
        )
      )
    ])
    error_message = "If IPv6 is requested (`assign_ipv6_address_on_creation` or `ipv6_native`), each subnet must provide either `ipv6_cidr_block`, or both `ipv6_ipam_pool_id` and `ipv6_netmask_length`."
  }

  # Customer-owned IP mapping dependencies
  validation {
    condition = alltrue([
      for _, s in var.private_subnets : (
        !s.map_customer_owned_ip_on_launch ||
        (s.customer_owned_ipv4_pool != null && s.outpost_arn != null)
      )
    ])
    error_message = "If `map_customer_owned_ip_on_launch` is true, then `customer_owned_ipv4_pool` and `outpost_arn` must both be provided."
  }
}

variable "private_subnets_enable_dns64" {
  description = "(Optional) Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. Default: false."
  type        = bool
  default     = false
}

variable "private_subnets_enable_resource_name_dns_aaaa_record_on_launch" {
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false."
  type        = bool
  default     = false
}

variable "private_subnets_enable_resource_name_dns_a_record_on_launch" {
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false."
  type        = bool
  default     = false
}

variable "private_subnets_private_dns_hostname_type_on_launch" {
  description = "(Optional) The type of hostnames to assign to instances in the subnet at launch. For IPv6-only subnets, an instance DNS name must be based on the instance ID. For dual-stack and IPv4-only subnets, you can specify whether DNS names use the instance IPv4 address or the instance ID. Valid values: ip-name, resource-name."
  type        = string
  default     = "ip-name"

  validation {
    condition     = contains(["ip-name", "resource-name"], var.private_subnets_private_dns_hostname_type_on_launch)
    error_message = "Only ip-name or resource-name are valid values for the var.private_subnets_private_dns_hostname_type_on_launch"
  }
}

variable "private_subnets_additional_tags" {
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

########################
# Flow Log configuration
########################
variable "flow_log_deliver_cross_account_role" {
  description = "(Optional) ARN of the IAM role in the destination account used for cross-account delivery of flow logs. This is required if log_destination_type is cloud-watch-logs or s3 and the destination is in a different account. Corresponds to DeliverCrossAccountRole in the AWS API."
  type        = string
  default     = null
}

variable "flow_log_iam_role_arn" {
  description = "(Optional) ARN of the IAM role used to post flow logs. Corresponds to DeliverLogsPermissionArn in the AWS API."
  type        = string
  default     = null
}

variable "flow_log_log_destination_type" {
  description = "(Optional) Logging destination type. Valid values: cloud-watch-logs, s3, kinesis-data-firehose. Default: cloud-watch-logs."
  type        = string
  default     = "cloud-watch-logs"

  validation {
    condition     = contains(["cloud-watch-logs", "s3", "kinesis-data-firehose"], var.flow_log_log_destination_type)
    error_message = "The flow_log_log_destination_type variable can only be set to one of ${join(", ", ["cloud-watch-logs", "s3", "kinesis-data-firehose"])}"
  }
}

variable "flow_log_log_destination" {
  description = "(Optional) ARN of the logging destination."
  type        = string
  default     = null
}

variable "flow_log_log_format" {
  description = "(Optional) The fields to include in the flow log record. Accepted format example: \"$${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport}\"."
  type        = string
  default     = null
}

variable "flow_log_max_aggregation_interval" {
  description = "(Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: 60 seconds (1 minute) or 600 seconds (10 minutes). Default: 600."
  type        = number
  default     = 600

  validation {
    condition     = var.flow_log_max_aggregation_interval == 60 || var.flow_log_max_aggregation_interval == 600
    error_message = "The flow_log_max_aggregation_interval variable can only be set to 60 or 600 seconds."
  }
}

variable "flow_log_traffic_type" {
  description = "(Optional) The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL. Default: ALL."
  type        = string
  default     = "ALL"

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], var.flow_log_traffic_type)
    error_message = "The flow_log_traffic_type variable can only be set to one of ${join(", ", ["ACCEPT", "REJECT", "ALL"])}"
  }
}

variable "flow_log_additional_tags" {
  description = "(Optional) Additional tags to be added to the flow log resources."
  type        = map(string)
  default     = {}
}

variable "flow_log_destination_options" {
  description = "(Optional) Describes the destination options for a flow log."
  type = object({
    file_format                = optional(string, "plain-text") # File format for the flow log. Default value: plain-text. Valid values: plain-text, parquet.
    hive_compatible_partitions = optional(bool, false)          # Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3. Default value: false.
    per_hour_partition         = optional(bool, false)          # Indicates whether to partition the flow log per hour. This reduces the cost and response time for queries. Default value: false.
  })
  default = {
    file_format                = "plain-text"
    hive_compatible_partitions = false
    per_hour_partition         = false
  }

  validation {
    condition     = contains(["plain-text", "parquet"], var.flow_log_destination_options.file_format)
    error_message = "The flow_log_destination_options.file_format variable can only be set to one of ${join(", ", ["plain-text", "parquet"])}"
  }
}

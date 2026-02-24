# trivy:ignore:AWS-0178 (MEDIUM): VPC does not have VPC Flow Logs enabled.
module "base-network" {
  source = "../../"

  # General settings
  name_prefix = "multi-az-zonal-nat"
  additional_tags = {
    global-additional-tag1 = "global-value1",
    global-additional-tag2 = "global-value2",
  }

  # VPC
  vpc_cidr_block                           = "192.168.0.0/16"
  vpc_assign_generated_ipv6_cidr_block     = false
  vpc_instance_tenancy                     = "default"
  vpc_ipv4_ipam_pool_id                    = null
  vpc_ipv4_netmask_length                  = null
  vpc_ipv6_cidr_block                      = null
  vpc_ipv6_ipam_pool_id                    = null
  vpc_ipv6_netmask_length                  = null
  vpc_ipv6_cidr_block_network_border_group = null
  vpc_enable_dns_hostnames                 = false
  vpc_enable_dns_support                   = true
  vpc_enable_network_address_usage_metrics = false
  vpc_additional_tags = {
    vpc-additional-tag1 = "vpc-value1",
    vpc-additional-tag2 = "vpc-value2",
  }
  vpc_create_internet_gateway = true
  vpc_enable_flow_log         = false

  # Public subnets
  public_subnets = {
    first-public = {
      availability_zone               = "us-east-1a"
      assign_ipv6_address_on_creation = false
      cidr_block                      = "192.168.0.0/24"
      # customer_owned_ipv4_pool        = null
      enable_flow_log     = false
      ipv6_cidr_block     = null
      ipv6_native         = false
      ipv4_ipam_pool_id   = null
      ipv4_netmask_length = null
      ipv6_ipam_pool_id   = null
      ipv6_netmask_length = null
      # map_customer_owned_ip_on_launch = false
      outpost_arn = null
    }
    second-public = {
      availability_zone               = "us-east-1b"
      assign_ipv6_address_on_creation = false
      cidr_block                      = "192.168.1.0/24"
      # customer_owned_ipv4_pool        = null
      enable_flow_log     = false
      ipv6_cidr_block     = null
      ipv6_native         = false
      ipv4_ipam_pool_id   = null
      ipv4_netmask_length = null
      ipv6_ipam_pool_id   = null
      ipv6_netmask_length = null
      # map_customer_owned_ip_on_launch = false
      outpost_arn = null
    }
    third-public = {
      availability_zone               = "us-east-1c"
      assign_ipv6_address_on_creation = false
      cidr_block                      = "192.168.2.0/24"
      # customer_owned_ipv4_pool        = null
      enable_flow_log     = false
      ipv6_cidr_block     = null
      ipv6_native         = false
      ipv4_ipam_pool_id   = null
      ipv4_netmask_length = null
      ipv6_ipam_pool_id   = null
      ipv6_netmask_length = null
      # map_customer_owned_ip_on_launch = false
      outpost_arn = null
    }
  }

  public_subnets_enable_dns64                                   = false
  public_subnets_enable_resource_name_dns_aaaa_record_on_launch = false
  public_subnets_enable_resource_name_dns_a_record_on_launch    = false
  public_subnets_map_public_ip_on_launch                        = false
  public_subnets_private_dns_hostname_type_on_launch            = "ip-name"
  public_subnets_additional_tags = {
    public-subnet-additional-tag1 = "public-subnet-value1",
    public-subnet-additional-tag2 = "public-subnet-value2"
  }

  # NAT Gateways
  nat_gateway_availability_mode  = "zonal"
  nat_gateway_availability_zones = ["us-east-1a", "us-east-1b"]
  nat_gateway_connectivity_type  = "public"
  nat_gateway_additional_tags = {
    nat-gateway-additional-tag1 = "nat-gateway-value1",
    nat-gateway-additional-tag2 = "nat-gateway-value2"
  }

  # Private Subnets
  private_subnets = {
    first-private = {
      availability_zone               = "us-east-1a"
      assign_ipv6_address_on_creation = false
      cidr_block                      = "192.168.128.0/24"
      # customer_owned_ipv4_pool        = null
      enable_flow_log     = false
      ipv6_cidr_block     = null
      ipv6_native         = false
      ipv4_ipam_pool_id   = null
      ipv4_netmask_length = null
      ipv6_ipam_pool_id   = null
      ipv6_netmask_length = null
      # map_customer_owned_ip_on_launch = false
      outpost_arn = null
    }
    second-private = {
      availability_zone               = "us-east-1b"
      assign_ipv6_address_on_creation = false
      cidr_block                      = "192.168.129.0/24"
      # customer_owned_ipv4_pool        = null
      enable_flow_log     = false
      ipv6_cidr_block     = null
      ipv6_native         = false
      ipv4_ipam_pool_id   = null
      ipv4_netmask_length = null
      ipv6_ipam_pool_id   = null
      ipv6_netmask_length = null
      # map_customer_owned_ip_on_launch = false
      outpost_arn = null
    }
  }

  private_subnets_enable_dns64                                   = false
  private_subnets_enable_resource_name_dns_aaaa_record_on_launch = false
  private_subnets_enable_resource_name_dns_a_record_on_launch    = false
  private_subnets_private_dns_hostname_type_on_launch            = "ip-name"
  private_subnets_additional_tags = {
    private-subnet-additional-tag1 = "private-subnet-value1",
    private-subnet-additional-tag2 = "private-subnet-value2"
  }

  # Flow Log configuration
  flow_log_deliver_cross_account_role = null
  flow_log_iam_role_arn               = null
  flow_log_log_destination_type       = "cloud-watch-logs"
  flow_log_log_destination            = null
  flow_log_log_format                 = null
  flow_log_max_aggregation_interval   = 600
  flow_log_traffic_type               = "ALL"
  flow_log_additional_tags = {
    flow-log-additional-tag1 = "flow-log-value1",
    flow-log-additional-tag2 = "flow-log-value2"
  }
  flow_log_destination_options = {
    file_format                = "plain-text"
    hive_compatible_partitions = false
    per_hour_partition         = false
  }
}

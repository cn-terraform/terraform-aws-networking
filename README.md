# Networking Terraform Module for AWS #

This Terraform module creates the base networking infrastructure on AWS.

[![](https://github.com/cn-terraform/terraform-aws-networking/workflows/terraform/badge.svg)](https://github.com/cn-terraform/terraform-aws-networking/actions?query=workflow%3Aterraform)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

## Install pre commit hooks.

Pleas run this command right after cloning the repository.

```bash
pre-commit install
```

For that you may need to install the following tools:
* [Pre-commit](https://pre-commit.com/)
* [Terraform Docs](https://terraform-docs.io/)

In order to run all checks at any point run the following command:

```bash
pre-commit run --all-files
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.32.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.private_subnet_flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.public_subnet_flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.vpc_flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_internet_gateway.internet_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_internet_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | (Optional) A map of tags to assign to all the resources. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_flow_log_additional_tags"></a> [flow\_log\_additional\_tags](#input\_flow\_log\_additional\_tags) | (Optional) Additional tags to be added to the flow log resources. | `map(string)` | `{}` | no |
| <a name="input_flow_log_deliver_cross_account_role"></a> [flow\_log\_deliver\_cross\_account\_role](#input\_flow\_log\_deliver\_cross\_account\_role) | (Optional) ARN of the IAM role in the destination account used for cross-account delivery of flow logs. This is required if log\_destination\_type is cloud-watch-logs or s3 and the destination is in a different account. Corresponds to DeliverCrossAccountRole in the AWS API. | `string` | `null` | no |
| <a name="input_flow_log_destination_options"></a> [flow\_log\_destination\_options](#input\_flow\_log\_destination\_options) | (Optional) Describes the destination options for a flow log. | <pre>object({<br/>    file_format                = optional(string, "plain-text") # File format for the flow log. Default value: plain-text. Valid values: plain-text, parquet.<br/>    hive_compatible_partitions = optional(bool, false)          # Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3. Default value: false.<br/>    per_hour_partition         = optional(bool, false)          # Indicates whether to partition the flow log per hour. This reduces the cost and response time for queries. Default value: false.<br/>  })</pre> | <pre>{<br/>  "file_format": "plain-text",<br/>  "hive_compatible_partitions": false,<br/>  "per_hour_partition": false<br/>}</pre> | no |
| <a name="input_flow_log_iam_role_arn"></a> [flow\_log\_iam\_role\_arn](#input\_flow\_log\_iam\_role\_arn) | (Optional) ARN of the IAM role used to post flow logs. Corresponds to DeliverLogsPermissionArn in the AWS API. | `string` | `null` | no |
| <a name="input_flow_log_log_destination"></a> [flow\_log\_log\_destination](#input\_flow\_log\_log\_destination) | (Optional) ARN of the logging destination. | `string` | `null` | no |
| <a name="input_flow_log_log_destination_type"></a> [flow\_log\_log\_destination\_type](#input\_flow\_log\_log\_destination\_type) | (Optional) Logging destination type. Valid values: cloud-watch-logs, s3, kinesis-data-firehose. Default: cloud-watch-logs. | `string` | `"cloud-watch-logs"` | no |
| <a name="input_flow_log_log_format"></a> [flow\_log\_log\_format](#input\_flow\_log\_log\_format) | (Optional) The fields to include in the flow log record. Accepted format example: "${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport}". | `string` | `null` | no |
| <a name="input_flow_log_max_aggregation_interval"></a> [flow\_log\_max\_aggregation\_interval](#input\_flow\_log\_max\_aggregation\_interval) | (Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: 60 seconds (1 minute) or 600 seconds (10 minutes). Default: 600. | `number` | `600` | no |
| <a name="input_flow_log_traffic_type"></a> [flow\_log\_traffic\_type](#input\_flow\_log\_traffic\_type) | (Optional) The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL. Default: ALL. | `string` | `"ALL"` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false. | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Required) The prefix to use for naming resources created in this module. | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | (Optional) Map of objects containing the definition for each private subnet | <pre>map(object({<br/>    availability_zone = string                # Availability Zone for the subnet.<br/>    cidr_block        = string                # The IPv4 CIDR block for the subnet.<br/>    enable_flow_log   = optional(bool, false) # (Optional) Whether to create a flow log for the subnet. Default is false. If enabled, some of the variables starting with `flow_log` need to be configured.<br/>  }))</pre> | `{}` | no |
| <a name="input_private_subnets_additional_tags"></a> [private\_subnets\_additional\_tags](#input\_private\_subnets\_additional\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_private_subnets_enable_resource_name_dns_a_record_on_launch"></a> [private\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch](#input\_private\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false. | `bool` | `false` | no |
| <a name="input_private_subnets_enable_resource_name_dns_aaaa_record_on_launch"></a> [private\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch](#input\_private\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false. | `bool` | `false` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | (Optional) Map of objects containing the definition for each public subnet | <pre>map(object({<br/>    availability_zone = string                # Availability Zone for the subnet.<br/>    cidr_block        = string                # The IPv4 CIDR block for the subnet.<br/>    enable_flow_log   = optional(bool, false) # (Optional) Whether to create a flow log for the subnet. Default is false. If enabled, some of the variables starting with `flow_log` need to be configured.<br/>  }))</pre> | `{}` | no |
| <a name="input_public_subnets_additional_tags"></a> [public\_subnets\_additional\_tags](#input\_public\_subnets\_additional\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_public_subnets_enable_resource_name_dns_a_record_on_launch"></a> [public\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch](#input\_public\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false. | `bool` | `false` | no |
| <a name="input_public_subnets_enable_resource_name_dns_aaaa_record_on_launch"></a> [public\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch](#input\_public\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false. | `bool` | `false` | no |
| <a name="input_single_nat"></a> [single\_nat](#input\_single\_nat) | Use single NAT Gateway | `bool` | `false` | no |
| <a name="input_vpc_additional_tags"></a> [vpc\_additional\_tags](#input\_vpc\_additional\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_vpc_assign_generated_ipv6_cidr_block"></a> [vpc\_assign\_generated\_ipv6\_cidr\_block](#input\_vpc\_assign\_generated\_ipv6\_cidr\_block) | (Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false. Conflicts with ipv6\_ipam\_pool\_id | `bool` | `false` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4\_netmask\_length. | `string` | `null` | no |
| <a name="input_vpc_create_internet_gateway"></a> [vpc\_create\_internet\_gateway](#input\_vpc\_create\_internet\_gateway) | (Optional) Whether to create an Internet Gateway and attach it to the VPC. Default is true. | `bool` | `true` | no |
| <a name="input_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#input\_vpc\_enable\_dns\_hostnames) | (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false. | `bool` | `false` | no |
| <a name="input_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#input\_vpc\_enable\_dns\_support) | (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults to true. | `bool` | `true` | no |
| <a name="input_vpc_enable_flow_log"></a> [vpc\_enable\_flow\_log](#input\_vpc\_enable\_flow\_log) | (Optional) Whether to create a flow log for the VPC. Default is false. If enabled, some of the variables starting with `flow_log` need to be configured. | `bool` | `false` | no |
| <a name="input_vpc_enable_network_address_usage_metrics"></a> [vpc\_enable\_network\_address\_usage\_metrics](#input\_vpc\_enable\_network\_address\_usage\_metrics) | (Optional) Indicates whether Network Address Usage metrics are enabled for your VPC. Defaults to false. | `bool` | `false` | no |
| <a name="input_vpc_instance_tenancy"></a> [vpc\_instance\_tenancy](#input\_vpc\_instance\_tenancy) | (Optional) A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee. | `string` | `"default"` | no |
| <a name="input_vpc_ipv4_ipam_pool_id"></a> [vpc\_ipv4\_ipam\_pool\_id](#input\_vpc\_ipv4\_ipam\_pool\_id) | (Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization. | `string` | `null` | no |
| <a name="input_vpc_ipv4_netmask_length"></a> [vpc\_ipv4\_netmask\_length](#input\_vpc\_ipv4\_netmask\_length) | (Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4\_ipam\_pool\_id. | `number` | `null` | no |
| <a name="input_vpc_ipv6_cidr_block"></a> [vpc\_ipv6\_cidr\_block](#input\_vpc\_ipv6\_cidr\_block) | (Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using ipv6\_netmask\_length. | `string` | `null` | no |
| <a name="input_vpc_ipv6_cidr_block_network_border_group"></a> [vpc\_ipv6\_cidr\_block\_network\_border\_group](#input\_vpc\_ipv6\_cidr\_block\_network\_border\_group) | (Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6\_cidr\_block\_network\_border\_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones. | `string` | `null` | no |
| <a name="input_vpc_ipv6_ipam_pool_id"></a> [vpc\_ipv6\_ipam\_pool\_id](#input\_vpc\_ipv6\_ipam\_pool\_id) | (Optional) IPAM Pool ID for a IPv6 pool. Conflicts with assign\_generated\_ipv6\_cidr\_block. | `string` | `null` | no |
| <a name="input_vpc_ipv6_netmask_length"></a> [vpc\_ipv6\_netmask\_length](#input\_vpc\_ipv6\_netmask\_length) | (Optional) Netmask length to request from IPAM Pool. Conflicts with ipv6\_cidr\_block. This can be omitted if IPAM pool as a allocation\_default\_netmask\_length set. Valid values are from 44 to 60 in increments of 4. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | Values from the generated Internet Gateway in case it was created. |
| <a name="output_nat_gws"></a> [nat\_gws](#output\_nat\_gws) | Values from the generated NAT gateways |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | Values from the generated private subnets |
| <a name="output_private_subnets_route_tables"></a> [private\_subnets\_route\_tables](#output\_private\_subnets\_route\_tables) | Values from the generated route tables for the private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | Values from the generated public subnets |
| <a name="output_public_subnets_route_tables"></a> [public\_subnets\_route\_tables](#output\_public\_subnets\_route\_tables) | Values from the generated route tables for the public subnets |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Values from the generated VPC. |
<!-- END_TF_DOCS -->

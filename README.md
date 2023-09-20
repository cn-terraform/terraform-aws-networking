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

        pre-commit install

For that you may need to install the folowwing tools:
* [Pre-commit](https://pre-commit.com/) 
* [Terraform Docs](https://terraform-docs.io/)

In order to run all checks at any point run the following command:

        pre-commit run --all-files

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
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
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4\_netmask\_length | `string` | `null` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false. | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_network_address_usage_metrics"></a> [enable\_network\_address\_usage\_metrics](#input\_enable\_network\_address\_usage\_metrics) | (Optional) Indicates whether Network Address Usage metrics are enabled for your VPC. Defaults to false. | `bool` | `false` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | (Optional) A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee. | `string` | `"default"` | no |
| <a name="input_ipv4_ipam_pool_id"></a> [ipv4\_ipam\_pool\_id](#input\_ipv4\_ipam\_pool\_id) | (Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization. | `string` | `null` | no |
| <a name="input_ipv4_netmask_length"></a> [ipv4\_netmask\_length](#input\_ipv4\_netmask\_length) | (Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4\_ipam\_pool\_id. | `number` | `null` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false. | `bool` | `false` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | (Optional) Map of objects contining the definition for each private subnet | <pre>map(object({<br>    availability_zone = string # Availability Zone for the subnet.<br>    cidr_block        = string # The IPv4 CIDR block for the subnet.<br>  }))</pre> | `{}` | no |
| <a name="input_private_subnets_additional_tags"></a> [private\_subnets\_additional\_tags](#input\_private\_subnets\_additional\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_private_subnets_enable_resource_name_dns_a_record_on_launch"></a> [private\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch](#input\_private\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false. | `bool` | `false` | no |
| <a name="input_private_subnets_enable_resource_name_dns_aaaa_record_on_launch"></a> [private\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch](#input\_private\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false. | `bool` | `false` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | (Optional) Map of objects contining the definition for each public subnet | <pre>map(object({<br>    availability_zone = string # Availability Zone for the subnet.<br>    cidr_block        = string # The IPv4 CIDR block for the subnet.<br>  }))</pre> | `{}` | no |
| <a name="input_public_subnets_additional_tags"></a> [public\_subnets\_additional\_tags](#input\_public\_subnets\_additional\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_public_subnets_enable_resource_name_dns_a_record_on_launch"></a> [public\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch](#input\_public\_subnets\_enable\_resource\_name\_dns\_a\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false. | `bool` | `false` | no |
| <a name="input_public_subnets_enable_resource_name_dns_aaaa_record_on_launch"></a> [public\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch](#input\_public\_subnets\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch) | (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false. | `bool` | `false` | no |
| <a name="input_single_nat"></a> [single\_nat](#input\_single\_nat) | Use single NAT Gateway | `bool` | `false` | no |
| <a name="input_vpc_additional_tags"></a> [vpc\_additional\_tags](#input\_vpc\_additional\_tags) | (Optional) A map of tags to assign to the VPC resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | ID of the generated Internet Gateway |
| <a name="output_nat_gws"></a> [nat\_gws](#output\_nat\_gws) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | ------------------------------------------------------------------------------ AWS Subnets - Private ------------------------------------------------------------------------------ |
| <a name="output_private_subnets_route_tables"></a> [private\_subnets\_route\_tables](#output\_private\_subnets\_route\_tables) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | ------------------------------------------------------------------------------ AWS Subnets - Public ------------------------------------------------------------------------------ |
| <a name="output_public_subnets_route_tables"></a> [public\_subnets\_route\_tables](#output\_public\_subnets\_route\_tables) | n/a |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | Amazon Resource Name (ARN) of VPC |
| <a name="output_vpc_default_network_acl_id"></a> [vpc\_default\_network\_acl\_id](#output\_vpc\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation |
| <a name="output_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#output\_vpc\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation |
| <a name="output_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#output\_vpc\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#output\_vpc\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support |
| <a name="output_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#output\_vpc\_enable\_dns\_support) | Whether or not the VPC has DNS support |
| <a name="output_vpc_enable_network_address_usage_metrics"></a> [vpc\_enable\_network\_address\_usage\_metrics](#output\_vpc\_enable\_network\_address\_usage\_metrics) | Whether Network Address Usage metrics are enabled for the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_instance_tenancy"></a> [vpc\_instance\_tenancy](#output\_vpc\_instance\_tenancy) | Tenancy of instances spin up within VPC |
| <a name="output_vpc_ipv6_association_id"></a> [vpc\_ipv6\_association\_id](#output\_vpc\_ipv6\_association\_id) | The association ID for the IPv6 CIDR block. |
| <a name="output_vpc_ipv6_cidr_block_network_border_group"></a> [vpc\_ipv6\_cidr\_block\_network\_border\_group](#output\_vpc\_ipv6\_cidr\_block\_network\_border\_group) | The Network Border Group Zone name |
| <a name="output_vpc_main_route_table_id"></a> [vpc\_main\_route\_table\_id](#output\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws\_main\_route\_table\_association. |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | The ID of the AWS account that owns the VPC. |
| <a name="output_vpc_tags_all"></a> [vpc\_tags\_all](#output\_vpc\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

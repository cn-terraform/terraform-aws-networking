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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.internet_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_internet_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_subnets_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_subnets_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_internet_route_table_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_internet_route_table_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional resource tags | `map(string)` | `{}` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones to be used by subnets | `list(any)` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for resources on AWS | `any` | n/a | yes |
| <a name="input_private_subnets_cidrs_per_availability_zone"></a> [private\_subnets\_cidrs\_per\_availability\_zone](#input\_private\_subnets\_cidrs\_per\_availability\_zone) | List of CIDRs to use on each availability zone for private subnets | `list(any)` | n/a | yes |
| <a name="input_public_subnets_cidrs_per_availability_zone"></a> [public\_subnets\_cidrs\_per\_availability\_zone](#input\_public\_subnets\_cidrs\_per\_availability\_zone) | List of CIDRs to use on each availability zone for public subnets | `list(any)` | n/a | yes |
| <a name="input_single_nat"></a> [single\_nat](#input\_single\_nat) | enable single NAT Gateway | `bool` | `false` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | AWS VPC CIDR Block | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of availability zones used by subnets |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | ID of the generated Internet Gateway |
| <a name="output_nat_gw_ids"></a> [nat\_gw\_ids](#output\_nat\_gw\_ids) | List with the IDs of the NAT Gateways created on public subnets to provide internet to private subnets |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | List with the Private Subnets IDs |
| <a name="output_private_subnets_route_table_id"></a> [private\_subnets\_route\_table\_id](#output\_private\_subnets\_route\_table\_id) | ID of the Route Table used on Private networks |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | List with the Public Subnets IDs |
| <a name="output_public_subnets_route_table_id"></a> [public\_subnets\_route\_table\_id](#output\_public\_subnets\_route\_table\_id) | ID of the Route Tables used on Public networks |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Networking Terraform Module for AWS #

This Terraform module creates the base networking infrastructure on AWS.

[![CircleCI](https://circleci.com/gh/cn-terraform/terraform-aws-networking/tree/master.svg?style=svg)](https://circleci.com/gh/cn-terraform/terraform-aws-networking/tree/master)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-networking)](https://github.com/cn-terraform/terraform-aws-networking)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.13 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Inputs

| Name                                             | Description                                                        | Type   | Default | Required |
| ------------------------------------------------ | ------------------------------------------------------------------ | ------ | ------- | :------: |
| availability\_zones                              | List of availability zones to be used by subnets                   | `list` | n/a     |   yes    |
| name\_prefix                                     | Name prefix for resources on AWS                                   | `any`  | n/a     |   yes    |
| private\_subnets\_cidrs\_per\_availability\_zone | List of CIDRs to use on each availability zone for private subnets | `list` | n/a     |   yes    |
| public\_subnets\_cidrs\_per\_availability\_zone  | List of CIDRs to use on each availability zone for public subnets  | `list` | n/a     |   yes    |
| single\_nat                                      | enable single NAT Gateway                                          | `bool` | `false` |    no    |
| vpc\_cidr\_block                                 | AWS VPC CIDR Block                                                 | `any`  | n/a     |   yes    |

## Outputs

| Name                               | Description                                                                                            |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------ |
| availability\_zones                | List of availability zones used by subnets                                                             |
| internet\_gateway\_id              | ID of the generated Internet Gateway                                                                   |
| nat\_gw\_ids                       | List with the IDs of the NAT Gateways created on public subnets to provide internet to private subnets |
| private\_subnets\_ids              | List with the Private Subnets IDs                                                                      |
| private\_subnets\_route\_table\_id | ID of the Route Table used on Private networks                                                         |
| public\_subnets\_ids               | List with the Public Subnets IDs                                                                       |
| public\_subnets\_route\_table\_id  | ID of the Route Tables used on Public networks                                                         |
| vpc\_cidr\_block                   | The CIDR block of the VPC                                                                              |
| vpc\_id                            | The ID of the VPC                                                                                      |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
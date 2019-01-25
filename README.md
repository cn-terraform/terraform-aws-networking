# Networking Terraform Module #

This Terraform module creates the base networking infrastructure.

## Amazon Web Services

### Usage
 
	module "networking" {
		source = "github.com/jnonino/networking-terraform-module//aws"
        name_preffix    = "base"
        profile         = "aws_profile"
        region          = "us-east-1"
        vpc_cidr        = "10.0.0.0/8"
        availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
        public_subnets_cidrs_per_availability_zone  = [ "10.0.0.0/11", "10.32.0.0/11", "10.64.0.0/11", "10.96.0.0/11" ]
        private_subnets_cidrs_per_availability_zone = [ "10.128.0.0/11", "10.160.0.0/11", "10.192.0.0/11", "10.224.0.0/11" ]
	}

### Output values

* vpc_id: The ID of the VPC.
* vpc_cidr_block: The CIDR block of the VPC.
* internet_gateway_id: The ID of the Internet Gateway.
* public_subnets_ids: IDs of generated public subnets.
* public_subnets_route_table_id: ID of the route table associated with public subnets.
* nat_gw_ids: IDs of the NAT gateways created on public subnets to provide internet to private subnets.
* private_subnets_ids: IDs of generated private subnets.
* private_subnets_route_table_id: ID of the route table associated with private subnets.

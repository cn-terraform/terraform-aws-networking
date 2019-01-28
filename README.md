# Networking Terraform Module for AWS #

This Terraform module creates the base networking infrastructure on AWS.

## Usage
 
	module "networking" {
		source = "jnonino/networking/aws"
        
        name_preffix    = "base"
        profile         = "aws_profile"
        region          = "us-east-1"
        vpc_cidr_block  = "192.168.0.0/16"
        availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
        public_subnets_cidrs_per_availability_zone  = [ "192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19" ]
        private_subnets_cidrs_per_availability_zone = [ "192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19" ]
	}

## Output values

* vpc_id: The ID of the VPC.
* vpc_cidr_block: The CIDR block of the VPC.
* internet_gateway_id: The ID of the Internet Gateway.
* public_subnets_ids: IDs of generated public subnets.
* public_subnets_route_table_id: ID of the route table associated with public subnets.
* nat_gw_ids: IDs of the NAT gateways created on public subnets to provide internet to private subnets.
* private_subnets_ids: IDs of generated private subnets.
* private_subnets_route_table_id: ID of the route table associated with private subnets.

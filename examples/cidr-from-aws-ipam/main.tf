data "aws_region" "current" {}

resource "aws_vpc_ipam" "test" {
  operating_regions {
    region_name = "us-east-1"
  }
}

resource "aws_vpc_ipam_pool" "test" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.test.private_default_scope_id
  locale         = data.aws_region.current.region
}

resource "aws_vpc_ipam_pool_cidr" "test" {
  ipam_pool_id = aws_vpc_ipam_pool.test.id
  cidr         = "172.20.0.0/16"
}

# trivy:ignore:AWS-0178 (MEDIUM): VPC does not have VPC Flow Logs enabled.
module "base-network" {
  source = "../../"

  name_prefix             = "cidr-from-aws-ipam"
  vpc_ipv4_ipam_pool_id   = aws_vpc_ipam_pool.test.id
  vpc_ipv4_netmask_length = 28

  vpc_additional_tags = {
    tag1 = "tag1",
    tag2 = "tag2"
  }
}

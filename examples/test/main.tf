module "base-network" {
  source         = "../../"
  name_prefix    = "test"
  single_nat     = true
  vpc_cidr_block = "192.168.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "192.168.0.0/19",
    "192.168.32.0/19"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "192.168.128.0/19",
    "192.168.160.0/19"
  ]

  additional_tags = {
    tag1 = "tag1",
    tag2 = "tag2",
  }
}

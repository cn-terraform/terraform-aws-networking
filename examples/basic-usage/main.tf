module "base-network" {
  source     = "../../"
  cidr_block = "10.0.0.0/16"
  vpc_additional_tags = {
    tag1 = "tag1",
    tag2 = "tag2",
  }
}

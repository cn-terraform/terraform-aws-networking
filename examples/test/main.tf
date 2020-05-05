provider "aws" {
  region = "us-east-1"
}

module "cluster" {
  source = "../../"
  name   = "test-cluster"
}

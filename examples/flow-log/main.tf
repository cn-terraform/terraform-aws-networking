######################
# CloudWatch log group
######################
# trivy:ignore:AWS-0017 (LOW): Log group is not encrypted.
resource "aws_cloudwatch_log_group" "flow_logs" {
  name = "flow-logs"
}

###################
# Flow log IAM role
###################
data "aws_iam_policy_document" "flow_logs_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "flow_logs_role" {
  name               = "flow-logs"
  assume_role_policy = data.aws_iam_policy_document.flow_logs_assume_role_policy.json
}

data "aws_iam_policy_document" "flow_logs_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "flow_logs_role_policy" {
  name   = "flow-logs"
  role   = aws_iam_role.flow_logs_role.id
  policy = data.aws_iam_policy_document.flow_logs_policy.json
}

module "base-network" {
  source = "../../"

  # General settings
  name_prefix = "flow-logs"
  additional_tags = {
    global-additional-tag1 = "global-value1",
    global-additional-tag2 = "global-value2",
  }

  # VPC
  vpc_cidr_block              = "192.168.0.0/16"
  vpc_create_internet_gateway = false
  vpc_enable_flow_log         = true

  # Public subnets
  public_subnets = {
    first-public = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.0.0/24"
      enable_flow_log   = true
    }
  }

  # NAT Gateways
  nat_gateway_availability_zones = []

  # Private Subnets
  private_subnets = {
    first-private = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.128.0/24"
      enable_flow_log   = true
    }
  }

  # Flow Log configuration
  flow_log_deliver_cross_account_role = null
  flow_log_iam_role_arn               = aws_iam_role.flow_logs_role.arn
  flow_log_log_destination_type       = "cloud-watch-logs"
  flow_log_log_destination            = aws_cloudwatch_log_group.flow_logs.arn
  flow_log_log_format                 = null
  flow_log_max_aggregation_interval   = 600
  flow_log_traffic_type               = "ALL"
  flow_log_additional_tags = {
    flow-log-additional-tag1 = "flow-log-value1",
    flow-log-additional-tag2 = "flow-log-value2"
  }
  flow_log_destination_options = {
    file_format                = "plain-text"
    hive_compatible_partitions = false
    per_hour_partition         = false
  }
}

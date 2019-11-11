resource "aws_vpc" "main" {
  provider             = "aws.networkadmin"
  cidr_block           = "${var.flags["vpc.main.cidr_block"]}"
  enable_dns_hostnames = "true"
  tags                 = "${merge(local.vpc_tags, local.common_tags)}"
}

resource "aws_default_route_table" "main" {
  provider               = "aws.networkadmin"
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"
  tags                   = "${merge(local.vpc_tags, local.common_tags)}"

  lifecycle {
    ignore_changes = ["route"]
  }
}

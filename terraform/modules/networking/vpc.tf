resource "aws_vpc" "main" {
  provider             = "aws.networkingadmin"
  cidr_block           = "${var.flags["main_vpc"]}"
  enable_dns_hostnames = "true"
  tags                 = "${merge(local.vpc_tags, local.common_tags)}"
}

resource "aws_default_route_table" "main" {
  provider               = "aws.networkingadmin"
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"
  tags                   = "${merge(local.vpc_tags, local.common_tags)}"

  lifecycle {
    ignore_changes = ["route"]
  }
}

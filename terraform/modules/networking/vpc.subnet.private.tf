# Private subnets

resource "aws_subnet" "main_private" {
  provider          = "aws.networkingadmin"
  count             = "${length(local.availability_zones)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, local.subnet_bits, length(local.availability_zones) + count.index)}"
  availability_zone = "${var.flags["region"]}${element(local.availability_zones, count.index)}"
  tags              = "${merge(local.common_tags, map("Name", "main-private-${element(local.availability_zones, count.index)}"))}"
}

resource "aws_route_table" "main_private" {
  provider          = "aws.networkingadmin"
  count             = "${length(local.availability_zones)}"
  vpc_id            = "${aws_vpc.main.id}"
  tags              = "${merge(local.common_tags, map("Name", "main-private-${element(local.availability_zones, count.index)}"))}"
}

resource "aws_route_table_association" "main_private" {
  provider          = "aws.networkingadmin"
  count             = "${length(local.availability_zones)}"
  subnet_id         = "${element(aws_subnet.main_private.*.id, count.index)}"
  route_table_id    = "${element(aws_route_table.main_private.*.id, count.index)}"
}

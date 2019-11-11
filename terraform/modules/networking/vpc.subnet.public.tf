# Public subnets

resource "aws_subnet" "main_public" {
  provider          = "aws.networkadmin"
  count             = "${length(local.availability_zones)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)}"
  availability_zone = "${var.flags["region"]}${element(local.availability_zones, count.index)}"
  tags              = "${merge(local.common_tags, map("Name", "main-public-${element(local.availability_zones, count.index)}"))}"
}

resource "aws_route_table" "main_public" {
  provider          = "aws.networkadmin"
  count             = "${length(local.availability_zones)}"
  vpc_id            = "${aws_vpc.main.id}"
  tags              = "${merge(local.common_tags, map("Name", "main-public-${element(local.availability_zones, count.index)}"))}"
}

resource "aws_route_table_association" "main_public" {
  provider          = "aws.networkadmin"
  count             = "${length(local.availability_zones)}"
  subnet_id         = "${element(aws_subnet.main_public.*.id, count.index)}"
  route_table_id    = "${element(aws_route_table.main_public.*.id, count.index)}"
}

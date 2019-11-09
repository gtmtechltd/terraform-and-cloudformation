# Security Groups

# Very important to destroy all rules in default security group => forces people to use a registered security group
resource "aws_default_security_group" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_security_group" "main-common" {
  name        = "main-common"
  description = "Common rules for all SGs"
  vpc_id      = "${aws_vpc.main.id}"
  tags        = "${merge(local.common_tags, map("Name", "main-common")}"
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = "${aws_vpc.main.cidr_block}"
  }
}

resource "aws_security_group" "main-ec2-test" {
  name        = "main-ec2-test"
  description = "Rules for ec2 test service"
  vpc_id      = "${aws_vpc.main.id}"
  tags        = "${merge(local.common_tags, map("Name", "main-ec2-test")}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${aws_vpc.main.cidr_block}"
  }
}

resource "aws_security_group" "main-lambda-foo" {
  name        = "main-common"
  description = "Rules for lambda function foo"
  vpc_id      = "${aws_vpc.main.id}"
  tags        = "${merge(local.common_tags, map("Name", "main-lambda-foo")}"
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${aws_vpc.main.cidr_block}"
  }
}

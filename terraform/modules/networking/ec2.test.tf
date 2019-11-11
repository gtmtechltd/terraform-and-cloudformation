resource "aws_instance" "test" {
  provider                    = "aws.computeadmin"
  ami                         = "${data.aws_ami.ubuntu.id}"
  availability_zone           = "${var.flags["region"]}${element(local.availability_zones, 0)}"
  instance_type               = "t2.nano"
  vpc_security_group_ids      = ["${aws_security_group.main-common.id}", "${aws_security_group.main-ec2-test.id}"]
  subnet_id                   = "${element(aws_subnet.main_private.*.id, 0)}"
  associate_public_ip_address = false
  tags                        = "${merge(local.common_tags, local.ec2_test_tags)}"
}

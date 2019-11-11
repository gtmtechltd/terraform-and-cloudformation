output "foo_sg" {
  value = "${aws_security_group.main-lambda-foo.id}"
}

output "foo_subnet" {
  value = "${element(aws_subnet.main_private.*.id, 0)}"
}

resource "aws_iam_role" "lambda_foo" {
  provider           = "aws.securityadmin"
  name               = "lambda-function-foo"
  assume_role_policy = "${file("${path.module}/policies/trust_lambda.json")}"
  tags               = "${merge(local.common_tags, map("Name", "lambda-foo"))}"
}

resource "aws_iam_role_policy" "lambda_foo_can_query_ec2" {
  provider = "aws.securityadmin"
  name     = "can-query-ec2"
  role     = "${aws_iam_role.lambda_foo.id}"
  policy   = "${file("${path.module}/policies/can_query_ec2.json")}"
}

data "external" "aws_cloudformation_package_foo2" {
  program = ["${path.module}/package.sh"]
  query = {
    path     = "${path.module}"
    bucket   = "${var.flags["company_name"]}-lambda-${var.flags["region"]}-${var.flags["environment"]}"
    function = "foo2"
  }
}

resource "aws_cloudformation_stack" "foo2" {
  name = "foo2-stack"

  parameters = {
    NodeEnv         = "${var.flags["environment"]}"
    SecurityGroupId = "${var.security_group_id}"
    SubnetId        = "${var.subnet_id}"
  }

  template_body     = "${data.external.aws_cloudformation_package_foo2.result["doc"]}"
  capabilities      = ["CAPABILITY_AUTO_EXPAND"]
}

resource "aws_iam_role" "security_admin" {
  provider             = "aws.administrator"
  path                 = "/"
  name                 = "securityAdmin"
  description          = "Role for managing security"
  assume_role_policy   = "${data.template_file.assume_role.rendered}"
  max_session_duration = "43200"
  tags                 = "${local.common_tags}"
}

data "template_file" "security_admin_can_manage_iam" {
  template = "${file("${path.module}/policies/can-manage-iam.json")}"
}

resource "aws_iam_role_policy" "security_admin_can_manage_iam" {
  provider = "aws.administrator"
  name     = "can-manage-iam"
  role     = "${aws_iam_role.security_admin.name}"
  policy   = "${data.template_file.security_admin_can_manage_iam.rendered}"
}

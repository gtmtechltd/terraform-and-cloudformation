resource "aws_iam_role" "compute_admin" {
  provider             = "aws.administrator"
  path                 = "/"
  name                 = "computeAdmin"
  description          = "Role for managing compute"
  assume_role_policy   = "${data.template_file.assume_role.rendered}"
  max_session_duration = "43200"
  tags                 = "${local.common_tags}"
}

data "template_file" "compute_admin_can_manage_compute" {
  template = "${file("${path.module}/policies/can-manage-compute.json")}"
}

resource "aws_iam_role_policy" "compute_admin_can_manage_compute" {
  provider = "aws.administrator"
  name     = "can-manage-compute"
  role     = "${aws_iam_role.compute_admin.name}"
  policy   = "${data.template_file.compute_admin_can_manage_compute.rendered}"
}

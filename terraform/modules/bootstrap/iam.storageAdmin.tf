resource "aws_iam_role" "storage_admin" {
  provider             = "aws.administrator"
  path                 = "/"
  name                 = "storageAdmin"
  description          = "Role for managing storage"
  assume_role_policy   = "${data.template_file.assume_role.rendered}"
  max_session_duration = "43200"
  tags                 = "${local.common_tags}"
}

data "template_file" "storage_admin_can_manage_s3" {
  template = "${file("${path.module}/policies/can-manage-s3.json")}"
}

resource "aws_iam_role_policy" "storage_admin_can_manage_s3" {
  provider = "aws.administrator"
  name     = "can-manage-s3"
  role     = "${aws_iam_role.storage_admin.name}"
  policy   = "${data.template_file.storage_admin_can_manage_s3.rendered}"
}

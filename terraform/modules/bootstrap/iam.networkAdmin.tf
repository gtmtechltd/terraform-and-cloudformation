resource "aws_iam_role" "network_admin" {
  provider             = "aws.administrator"
  path                 = "/"
  name                 = "networkAdmin"
  description          = "Role for managing networks"
  assume_role_policy   = "${data.template_file.assume_role.rendered}"
  max_session_duration = "43200"
  tags                 = "${local.common_tags}"
}

data "template_file" "network_admin_can_manage_networks" {
  template = "${file("${path.module}/policies/can-manage-networks.json")}"
  vars = {
    COMPANY_NAME = "${var.flags["company_name"]}"
    REGION       = "${var.flags["region"]}"
    ENVIRONMENT  = "${var.flags["environment"]}"
    PATH         = "/"
  }
}

resource "aws_iam_role_policy" "network_admin_can_manage_networks" {
  provider = "aws.administrator"
  name     = "can-manage-networks"
  role     = "${aws_iam_role.network_admin.name}"
  policy   = "${data.template_file.network_admin_can_manage_networks.rendered}"
}

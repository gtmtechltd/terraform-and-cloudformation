resource "aws_iam_role" "terraform_state_writer" {
  provider             = "aws.administrator"
  path                 = "/"
  name                 = "terraformStateWriter"
  description          = "Role for managing terraform state"
  assume_role_policy   = "${data.template_file.assume_role.rendered}"
  max_session_duration = "43200"
  tags                 = "${local.common_tags}"
}

data "template_file" "terraform_state_writer_can_manage_terraform_state" {
  template = "${file("${path.module}/policies/can-manage-terraform-state.json")}"
  vars = {
    COMPANY_NAME = "${var.flags["company_name"]}"
    REGION       = "${var.flags["region"]}"
    ENVIRONMENT  = "${var.flags["environment"]}"
    PATH         = "/"
  }
}

resource "aws_iam_role_policy" "terraform_state_writer_can_manage_terraform_state" {
  provider = "aws.administrator"
  name     = "can-manage-terraform-state"
  role     = "${aws_iam_role.terraform_state_writer.name}"
  policy   = "${data.template_file.terraform_state_writer_can_manage_terraform_state.rendered}"
}

data "aws_caller_identity" "current" {}

data "template_file" "assume_role" {
  template = "${file("${path.module}/policies/assume_role.json")}"
  vars = {
    ACCOUNT_ID = "${data.aws_caller_identity.current.account_id}"
  }
}

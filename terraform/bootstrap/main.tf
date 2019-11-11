module "bootstrap" {
  source = "modules/bootstrap"
  flags  = "${local.flags}"
  providers {
    aws.administrator = "aws.administrator"
  }
}

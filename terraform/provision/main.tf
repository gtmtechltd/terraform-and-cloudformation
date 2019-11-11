module "networking" {
  source = "modules/networking"
  flags  = "${local.flags}"
  providers {
    aws.networkadmin = "aws.networkadmin"
    aws.computeadmin = "aws.computeadmin"
    aws.securityadmin = "aws.securityadmin"
  }
}

module "lambda" {
  source = "modules/lambda"
  flags  = "${local.flags}"
  providers {
    aws.storageadmin = "aws.storageadmin"
  }
}

module "cloudformation" {
  source            = "modules/cloudformation"
  flags             = "${local.flags}"
  security_group_id = "${module.networking.foo_sg}"
  subnet_id         = "${module.networking.foo_subnet}"
  providers {
    aws.storageadmin = "aws.storageadmin"
  }
}

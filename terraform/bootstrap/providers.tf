# Bootstrap is the only minimal infra that must be created with an administrator role

provider "aws" {
  alias   = "administrator"
  region  = "${local.flags["region"]}"
  version = "2.4"
}

provider "aws" {
  region = "eu-west-1"
}

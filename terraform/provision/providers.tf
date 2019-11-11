provider "aws" {
  alias          = "networkadmin"
  region         = "${local.flags["region"]}"
  version        = "2.4"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/networkAdmin"
    session_name = "terraform"
  }
}

provider "aws" {
  alias          = "computeadmin"
  region         = "${local.flags["region"]}"
  version        = "2.4"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/computeAdmin"
    session_name = "terraform"
  }
}

provider "aws" {
  alias          = "securityadmin"
  region         = "${local.flags["region"]}"
  version        = "2.4"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/securityAdmin"
    session_name = "terraform"
  }
}

provider "aws" {
  alias          = "storageadmin"
  region         = "${local.flags["region"]}"
  version        = "2.4"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/storageAdmin"
    session_name = "terraform"
  }
}

provider "aws" {
  region = "eu-west-1"
}

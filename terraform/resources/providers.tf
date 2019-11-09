provider "aws" {
  alias          = "networkingadmin"
  region         = "${var.region}"
  version        = "2.4"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/networkAdmin"
    session_name = "terraform"
  }
}

provider "aws" {
  alias          = "computeadmin"
  region         = "${var.region}"
  version        = "2.4"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/computeAdmin"
    session_name = "terraform"
  }
}

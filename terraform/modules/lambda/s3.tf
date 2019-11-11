resource "aws_s3_bucket" "lambda_functions" {
  provider      = "aws.storageadmin"
  acl           = "private"
  bucket        = "${var.flags["company_name"]}-lambda-${var.flags["region"]}-${var.flags["environment"]}"
  region        = "${var.flags["region"]}"
  force_destroy = "false"
  versioning {
    enabled = "true"
  }
  lifecycle_rule {
    id      = "expunge"
    enabled = true
    prefix  = "/"
    tags = {
      "rule"      = "log"
      "autoclean" = "true"
    }
    noncurrent_version_expiration {
      days = 30
    }
  }
  tags = "${merge(local.common_tags, map("Name", "lambda"))}"

  # Ignore all changes for s3 bucket terraform states
  lifecycle {
    ignore_changes = "all"
  }
}

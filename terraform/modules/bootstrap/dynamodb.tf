resource "aws_dynamodb_table" "terraform_locks" {
  provider       = "aws.administrator"
  name           = "tflocks-${var.flags["region"]}"

  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${merge(local.common_tags, map("Name", "tflocks"))}"

  # Ignore all changes for bootstrapped terraform dynamodb tables
  lifecycle {
    ignore_changes = "all"
  }
}

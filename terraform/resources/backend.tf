terraform {
  required_version = "=0.11.14"

  # Configure where to store the terraform state. We choose S3
  # We inject variables here from commandline so that we store
  # region Xs terraform state in a region X bucket
  # This removes interregion dependencies

  backend "s3" {
    # bucket         = "..."  # supplied from .terraformrc
    # key            = "..."  # supplied from .terraformrc
    # region         = "..."  # supplied from .terraformrc
    acl              = "private"
    # dynamodb_table = "..."  # supplied from .terraformrc
    # role_arn       = "..."  # supplied from .terraformrc
  }
}

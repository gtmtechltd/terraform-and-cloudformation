terraform {
  required_version = "=0.11.14"

  # Configure where to store the terraform state. We choose S3
  # We inject variables here from commandline so that we store
  # region Xs terraform state in a region X bucket
  # This removes interregion dependencies
}

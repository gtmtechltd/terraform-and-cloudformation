locals {
  vpc_tags = {
    Name  = "main"
    Id    = "main.${var.flags["region"]}"
  }

  common_tags = {
    Owner = "devops"
  }

  ec2_test_tags = {
    Name = "test"
  }
}

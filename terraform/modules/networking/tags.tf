locals {
  vpc_tags = {
    Name  = "main"
    Id    = "main.${var.flags["region"]}"
  }

  common_tags = {
    Owner = "devops"
  }
}

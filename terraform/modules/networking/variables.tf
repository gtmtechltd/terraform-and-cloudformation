variable "flags" { type = "map" }

locals {
  availability_zones = "${split(",", var.flags["availability_zones"])}"
}

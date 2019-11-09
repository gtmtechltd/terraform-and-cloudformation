variable "flags" { type = "map" }

locals {
  availablity_zones = "${split(",", var.flags["availability_zones"]}"
}

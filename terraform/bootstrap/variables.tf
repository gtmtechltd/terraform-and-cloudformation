variable "flags"        { type = "map" }
variable "flags_cli"    { type = "map" }
variable "flags_common" { type = "map" }

locals {
  flags = "${merge(var.flags_common, var.flags, var.flags_cli)}"
}

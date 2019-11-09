#!/bin/sh

die() {
  echo "$@" >&2
  exit 1
}

[ -z "$1" ] && die "Usage: $0 <action> <environment> [args] e.g. $0 plan production, $0 apply staging"

full_environment="$1"
environment="${full_environment//.}"
region="${full_environment//.}"
[ -z "${region}" ] && region="eu-west-1"

terraform "${action}" "$@" -var-file "environments/${environment}.eu-west-1.tfvars" -var-file "environments/common.tfvars" -var="region=${region}" resources

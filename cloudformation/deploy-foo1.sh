#!/bin/bash

die() {
  echo "$@" >&2
  exit 1
}

[ -z "$1" ] && die "Usage: $0 <environment>"

COMPANY_NAME=gtmtechltd
ENVIRONMENT=$1
TMPFILE="$( mktemp /tmp/cf.XXXXXX )"

SECURITY_GROUP_ID="$(
  aws ec2 describe-security-groups \
          --region eu-west-1 \
          --query 'SecurityGroups[?GroupName==`main-lambda-foo`].GroupId' \
          --output text)"

SUBNET_ID="$(
  aws ec2 describe-subnets \
          --region eu-west-1 \
          --query 'Subnets[].{SubnetId: SubnetId, Name: (Tags[?Key==`Name`].Value)[0]}[?Name==`main-private-a`].SubnetId' \
          --output text)"

set -x
aws --region eu-west-1 cloudformation package \
    --template-file foo1.json \
    --s3-bucket ${COMPANY_NAME}-lambda-eu-west-1-${ENVIRONMENT} \
    --use-json \
    --output-template-file "${TMPFILE}" >&2

aws --region eu-west-1 cloudformation deploy \
    --template-file "${TMPFILE}" \
    --stack-name foo1-stack \
    --parameter-overrides NodeEnv=test "SecurityGroupId=${SECURITY_GROUP_ID}" "SubnetId=${SUBNET_ID}"


#!/bin/bash

export PATH=$PATH:/usr/local/bin

INPUT="$(cat -)"
PATH="$(echo "${INPUT}" | /usr/local/bin/jq -r .path)"
BUCKET="$(echo "${INPUT}" | /usr/local/bin/jq -r .bucket)"
FUNCTION="$(echo "${INPUT}" | /usr/local/bin/jq -r .function)"

echo "-----" >> /tmp/buck1
echo "${BUCKET}" >> /tmp/buck1
echo "${FUNCTION}" >> /tmp/buck1

echo "1" >> /tmp/buck1

TMPFILE=$(/usr/bin/mktemp /tmp/cf.XXXXXX)

echo "2" >> /tmp/buck1

set -e
CMD="aws --region eu-west-1 cloudformation package \
         --template-file ${PATH}/${FUNCTION}.json \
         --s3-bucket ${BUCKET} \
         --use-json \
         --output-template-file ${TMPFILE}" 
echo "3" >> /tmp/buck1

echo "$CMD" >> /tmp/buck1

echo "4" >> /tmp/buck1

/usr/local/bin/aws --region eu-west-1 cloudformation package \
    --template-file ${PATH}/${FUNCTION}.json \
    --s3-bucket ${BUCKET} \
    --use-json \
    --output-template-file ${TMPFILE} >> /tmp/buck1 2>&1

echo "5" >> /tmp/buck1

/usr/local/bin/jq -r '. | {doc: .|tostring}' < "${TMPFILE}"

#!/bin/sh

S3_BUCKET=shared-state-test
S3_FOLDER="$GITPOD_GIT_USER_EMAIL"

SHARED_FOLDER="$GITPOD_REPO_ROOT/shared"

# Create the folder if it does not exist
if ! aws s3 ls "s3://$S3_BUCKET/$S3_FOLDER" 2>&1 | grep -q 'PRE'; then
  aws s3api put-object --bucket "$S3_BUCKET" --key "$S3_FOLDER"
fi

[ -d "$SHARED_FOLDER" ] || mkdir "$SHARED_FOLDER"
s3fs "$S3_BUCKET:/$S3_FOLDER" "$SHARED_FOLDER"
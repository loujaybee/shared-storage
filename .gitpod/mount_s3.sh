#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Example usage if needed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <s3-bucket-name> <local-folder>"
  exit 1
fi

S3_BUCKET=$1
SHARED_FOLDER=$2
S3_FOLDER="$GITPOD_GIT_USER_EMAIL"

# Create the folder if it does not exist
if ! aws s3 ls "s3://$S3_BUCKET/$S3_FOLDER" 2>&1 | grep -q 'PRE'; then
  aws s3api put-object --bucket "$S3_BUCKET" --key "$S3_FOLDER"
fi

# Mount the folder
[ -d "$SHARED_FOLDER" ] || mkdir "$SHARED_FOLDER"
s3fs "$S3_BUCKET:/$S3_FOLDER" "$SHARED_FOLDER"
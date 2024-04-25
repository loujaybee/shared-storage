#!/bin/sh

SHARED_FOLDER=/workspace/shared
S3_BUCKET=shared-state-test

sudo mkdir "$SHARED_FOLDER"
sudo chown -R gitpod:gitpod "$SHARED_FOLDER"
s3fs "$S3_BUCKET" "$SHARED_FOLDER"

mkdir "$SHARED_FOLDER/secretsauce"
ln -s "$SHARED_FOLDER/secretsauce" /workspace/m2-repository/com/mycompany/secretsauce

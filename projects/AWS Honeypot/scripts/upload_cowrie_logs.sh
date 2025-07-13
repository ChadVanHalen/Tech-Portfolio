#!/bin/bash

# Variables
LOG_FILE="/home/ubuntu/docker-cowrie/cowrie_var_logs/log/cowrie/cowrie.json"
S3_BUCKET="honeypot-logs-cowrie"
TIMESTAMP=$(date +%F-%T)
S3_KEY="cowrie/logs/cowrie-$TIMESTAMP.json"

# Upload the log file to S3
aws s3 cp "$LOG_FILE" "s3://$S3_BUCKET/$S3_KEY"

# Check for success/failure
if [ $? -eq 0 ]; then
  echo "Upload successful: s3://$S3_BUCKET/$S3_KEY"
else
  echo "Upload failed"
fi

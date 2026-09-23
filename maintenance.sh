#!/bin/bash

log_file="/home/ubuntu/devops-zero-to-hero/maintenance.log"

echo "----------------------------------------" >> "$log_file"
echo "$(date) - Maintenance Started" >> "$log_file"

echo "Running Log Rotation..." >> "$log_file"
/home/ubuntu/devops-zero-to-hero/scripts/log_rotate.sh >> "$log_file" 2>&1

echo "Running Backup..." >> "$log_file"
/home/ubuntu/devops-zero-to-hero/scripts/backup.sh >> "$log_file" 2>&1

echo "$(date) - Maintenance Completed" >> "$log_file"
echo "----------------------------------------" >> "$log_file"

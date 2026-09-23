#!/bin/bash

log_dir="/home/ubuntu/devops-zero-to-hero/logs"

if [ ! -d "$log_dir" ]; then
    echo "Log directory does not exist."
    exit 1
fi

echo "Starting Log Rotation..."

find "$log_dir" -name "*.log" -mtime +7 -exec gzip {} \;

echo "Old log files compressed."

find "$log_dir" -name "*.gz" -mtime +30 -delete

echo "Old compressed files deleted."

echo "Log Rotation Completed Successfully."

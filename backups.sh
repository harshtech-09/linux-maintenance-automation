#!/bin/bash

source_dir="/home/ubuntu/devops-zero-to-hero/scripts"
destination_dir="/home/ubuntu/devops-zero-to-hero/backups"

function create_backup {

    if [ ! -d "$source_dir" ]; then
        echo "Source directory does not exist."
        exit 1
    fi

    mkdir -p "$destination_dir"

    timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

    backup_file="${destination_dir}/backup_${timestamp}.tar.gz"

    tar -czf "$backup_file" "$source_dir"

    if [ -f "$backup_file" ]; then
        echo "Backup Completed Successfully."
        echo "Backup File: $backup_file"

        size=$(du -h "$backup_file" | cut -f1)
        echo "Backup Size: $size"
    else
        echo "Backup Failed."
        exit 1
    fi

    find "$destination_dir" -name "*.tar.gz" -mtime +14 -delete

    echo "Old backups deleted."
}

create_backup

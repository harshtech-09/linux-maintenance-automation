#!/bin/bash

echo "Starting Health Check..."

echo "Date: $(date)"

echo "Hostname: $(hostname)"

echo "System Uptime:"
uptime

echo "Disk Usage:"
df -h /

echo "Health Check Completed Successfully."

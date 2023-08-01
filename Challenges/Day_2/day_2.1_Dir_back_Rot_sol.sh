#!/bin/bash

backup_dir="/home/ubuntu/backups"  # Replace with the desired backup directory path
source_dir="/home/ubuntu/BashBlaze-7-Days-of-Bash-Scripting-Challenge"  # Replace with the source directory whose contents you want to back up

# Create the backup directory if it doesn't exist
#mkdir -p "$backup_dir"

# Create timestamped backup folder
timestamp=$(date +"%Y%m%d%H%M%S")
backup_folder="$backup_dir/backup_$timestamp"
mkdir "$backup_folder"

# Copy all files from specified directory into the backup folder
cp -R "$source_dir"/* "$backup_folder"

# Keep only the last 3 backups, remove older backups
num_backups_to_keep=3
backup_count=$(ls -d "$backup_dir/backup_"* 2>/dev/null | wc -l)

if [ "$backup_count" -gt "$num_backups_to_keep" ]; then
    num_backups_to_remove=$((backup_count - num_backups_to_keep))
    backups_to_remove=$(ls -d "$backup_dir/backup_"* 2>/dev/null | sort | head -n "$num_backups_to_remove")
    rm -rf $backups_to_remove
fi

echo "Backup created successfully in: $backup_folder"


#!/bin/bash
#check if command line argument is equal to zero
if [ $# -eq 0 ] 
then
	echo "kindly enter directory path from command line argument  "
        exit 1
fi
#If no arguments were provided, the script prints a message and exits with status code 1.

#get the directory path from command line argument
source_dir=$1
#$1 represents the first command-line argument passed to the script.
#It assigns the value of the first argument to the variable source_dir.


#check if specified directory exists or not
if [ ! -d "$source_dir" ]
then
	echo "Error: specified directory doesnot exists"
	exit 1
fi
# This block checks whether the specified directory exists.
# ! is used for negation, -d checks if the argument is a directory.
# If the directory does not exist, the script prints an error message and exits.

#specifing backup directory
backup_dir="/home/ubuntu/backups"
# This variable holds the path where backup folders will be created.

# Create the backup directory if it doesn't exist
#mkdir -p "$backup_dir"

# This command creates the backup directory if it doesn't exist.
# -p ensures that parent directories are created as needed, even if they don't exist.

#to create time stamped backup folder
timestamp=$(date +"%Y%m%d%H%M%S")
backup_folder="$backup_dir/backup_$timestamp"
mkdir "$backup_folder"
# This section generates a timestamp using the date command.
# The format +%Y%m%d%H%M%S specifies the year, month, day, hour, minute, and second.
# It then creates a backup folder using the generated timestamp.

# Copy all files from specified directory into the backup folder
cp -R "$source_dir"/* "$backup_folder"
# This command recursively copies all files and directories from the source directory
# into the newly created backup folder


# Rotation mechanism: Keep only the last 3 backups, remove older backups
num_backups_to_keep=3

# The variable 'num_backups_to_keep' is set to 3 to indicate we want to retain the last 3 backups.



backups=($(ls -t "$backup_dir" | grep "^backup_" | tail -n +$((num_backups_to_keep + 1))))

#The ls -t command in a shell is used to list files in a directory based on their modification timestamp, with the most recently modified files listed first
# The output is then filtered to only include backup folders (those starting with "backup_") using 'grep'.
# 'tail -n +$((num_backups_to_keep + 1))' excludes the last 3 backups, keeping older ones.
# The result is stored in the 'backups' array.

for backup in "${backups[@]}"; do 
	rm -rf "$backup_dir/$backup"
done
# The loop iterates through the backup folders that need to be removed,
# and 'rm -rf' forcefully removes each backup folder.

echo "Backup created successfully in: $backup_folder"
#a success message is printed, indicating where the backup was created.


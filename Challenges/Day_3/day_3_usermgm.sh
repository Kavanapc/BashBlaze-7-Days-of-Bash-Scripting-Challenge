#!/bin/bash

# Function to check if a user exists
function check_user_existence {
    local username=$1
    id "$username" &>/dev/null
    return $?
}

# Function to create a new user account
function create_user {
    read -p "Enter new username: " username

    if check_user_existence "$username"; then
        echo "Username '$username' already exists. Exiting."
        exit 1
    fi

    read -sp "Enter password: " password
    echo

    sudo useradd -m -s /bin/bash "$username"
    echo "$username:$password" | sudo chpasswd

    echo "User '$username' created successfully."
}

# Function to delete a user account
function delete_user {
    read -p "Enter username to delete: " username

    if ! check_user_existence "$username"; then
        echo "Username '$username' does not exist. Exiting."
        exit 1
    fi

    sudo userdel -r "$username"
    echo "User '$username' deleted successfully."
}

# Function to reset user password
function reset_password {
    read -p "Enter username to reset password: " username

    if ! check_user_existence "$username"; then
        echo "Username '$username' does not exist. Exiting."
        exit 1
    fi

    read -sp "Enter new password: " password
    echo

    echo "$username:$password" | sudo chpasswd

    echo "Password for user '$username' reset successfully."
}

# Function to list user accounts
function list_users {
    echo "List of user accounts:"
    awk -F: '$3 >= 1000 {print "Username:", $1, "UID:", $3}' /etc/passwd
}

# Function to display usage information
function display_usage {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c, --create   Create a new user account"
    echo "  -d, --delete   Delete an existing user account"
    echo "  -r, --reset    Reset the password of an existing user account"
    echo "  -l, --list     List all user accounts"
    echo "  -h, --help     Display this help message"
}

# Main script
if [[ $# -eq 0 ]]; then
    display_usage
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--create)
            create_user
            ;;
        -d|--delete)
            delete_user
            ;;
        -r|--reset)
            reset_password
            ;;
        -l|--list)
            list_users
            ;;
        -h|--help)
            display_usage
            ;;
        *)
            echo "Invalid option: $1"
            display_usage
            exit 1
            ;;
    esac
    shift
done

exit 0


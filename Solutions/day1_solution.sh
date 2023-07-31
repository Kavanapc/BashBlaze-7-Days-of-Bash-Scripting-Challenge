#!/bin/bash
#Task-1:Welcome to Day 1 of the Bash Scripting Challenge! 
#Task-2:The echo command in shell scripting is used to display messages or output to the terminal or console. It allows you to print text or variables to the screen, which is particularly useful for providing information or feedback to users or for debugging purposes.
echo "here is the solution for day 1 of Bash Scripting Challenge"
#Task-3:variable assignment
a=10
b=20
#Task-4:Accessing variables:Variable data could be accessed by appending the variable name with ‘$’ 
echo "sum of given numbers is $((a+b))"
#Task-5:built-in variables
echo "Username of current user is: $USER "
echo "Home directory of current user is: $HOME"
echo "version of bash shell is: $BASH_VERSION"
echo "Script name: $0"
#Task-6:Wildcards:Wildcards are special characters used to perform pattern matching when working with files.Here * is used to list all the file with .txt extenion in current working directory
ls *.txt





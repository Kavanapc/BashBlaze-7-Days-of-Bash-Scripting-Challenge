#!/bin/bash
echo "Welcome to Day 2 of the Bash Scripting Challenge!"
echo "Files and Directories in the Current Path:"
ls -lh | awk '{print "-", $9 ,"(",$5,")"}' 
echo "Character Counting"
while true; do
	read -p "Enter a line of text (Press Enter without text to exit):" txt
	if [ ${#txt} = 0 ]
	then
		echo "Exiting the Interactive Explorer. Goodbye!"
		break
	fi
	echo "Character Count: ${#txt}"
done

#!/bin/bash
# Reading lines in /etc/fstab

File=/etc/fstab

{
read line1
read line2
} < $File

echo "First line is $File is:"
echo "$line1"
echo
echo "Second line in $File is:"
echo "$line2"

exit 0

# Now, how you parse the separate fields of each line?
# Hint: use awk, or . . .
# . . . Hans=Joerg Diers suggests using the "set" Bash builtin.

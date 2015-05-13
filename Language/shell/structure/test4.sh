#!/bin/bash
testuser=badtest
if grep $testuser /etc/passwd
then
    echo The file for user $testuser are:
    ls -a /home/$testuser/.b*
else
    echo "The user name $testuser does not exist on this system"
fi


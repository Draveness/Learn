#!/bin/bash
if [ -e $HOME ]
then
    echo "OK on the directory. not to check the file"
    if [ -e $HOME/testing ]
    then
        echo "Appending date to existing file"
        date >> $HOME/testing
    else
        echo "Creating new file"
        date > $HOME/testing
    fi
else
    echo "Sorry, you do not have a HOME directory"
fi

#!/bin/bash
if [ -d $HOME ]
then
    echo "Your $HOME directory exists"
    cd $HOME
    ls -a
else
    echo "There is a problem with your HOME directory"
fi


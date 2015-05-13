#!/bin/bash
if grep $testuser /etc/password
then
    echo The bash files for user $testuser are:
    ls -a /home/$testuser/.b*
fi

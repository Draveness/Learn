#!/bin/bash

val1=` echo "scale=4; 10 / 3 " | bc`
echo "The test value is $val1"
if [ $val1 -gt 3 ]
then
    echo "The result is larger then 3"
fi


#!/bin/bash
# weirdvars.sh: Echoing weird variables.

echo

var="'(]\\{}\$\""
echo $var
echo "$var"

echo
IFS='\'
echo $var
echo "$var"

echo

var="\\\\\""
echo $var2
echo "\$var2 = $var2"
echo

var3='\\\\'
echo "$var3"


echo "$(echo '"')"

var1="Two bits"
echo "\$var1 = "$var1""



#!/bin/bash
# excaped.sh: escaped characters

echo ""
echo "This will print as two
lines."

echo "This will print \
    as one line/"

echo; echo

echo "============="

echo "\v\v\v\v"

echo "============="
echo "VERTICAL TABS"
echo -e "\v\v\v\v"

echo "============="
echo "QUOTATION MARK"
echo -e "\042"

echo "============="

echo; echo "NEWLINE and (maybe) BEEP"
echo $'\n'
echo $'\a'

echo "Introducing the \$\' ... \' string-expansion construct . . . "
echo ". . . featuring more quotation marks."

echo $'\t \042 \t'

echo $'\t \x22 \t'

echo

quote=$'\042'
echo "$quote Quoted string $quote and this lies outside the quoted."

echo

triple_underline=$'\137\137\137'
echo "$triple_underline UNDERLINE $triple_underline"

echo

ABC=$'\101\102\103\010'
echo $ABC

echo

excape=$'\033'
echo "\"escape\" echoes as $escape"

echo

exit 0

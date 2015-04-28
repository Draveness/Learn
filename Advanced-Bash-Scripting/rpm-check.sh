#!/bin/bash
# rpm-check.sh

#  Queries an rpm file for description, listing,
#+ and whether it can be installed.
#  Save output to a file.
#
#  This script illustrates using a code block.


SUCCESS=0
E_NOARGS=65

if [ -z "$1" ]
then
    echo "Usage: `basename $0` rpm-file"
    exit $E_NOARGS
fi

{   # Begin code block.
    echo
    echo "Archieve Description:"
    rpm -qpi $1             # Query description
    echo
    echo "Archieve Listing:"
    rpm -qpl $1             # Query listing.
    echo
    rpm -i --test $1        # Query whether rpm file can be installed.
    if [ "$?" -eq $SUCCESS ]
    then
        echo "$1 can be installed."
    else
        echo "$1 cannot be installed."
    fi
    echo
} > "$1.test"

echo "Results of rpm test in file $1.test"

# See rpm man page for explanation of options.

exit 0

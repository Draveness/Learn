#!/bin/bash
# ex18.sh

# Does a 'whois domain-name' lookop on any of 3 alternate servers:
#                    ripe.net, cw.net, radb.net

# Place this script -- renamned 'wh' -- in /usr/local/nom

# Requires symbolic links:
# ln -s /usr/local/bin/wh /usr/local/bin/wh-ripe
# ln -s /usr/local/bin/wh /usr/local/bin/wh-apnic
# ln -s /usr/local/bin/wh /usr/local/bin/wh-tucows

E_NOARGS=75

if [ -z "$1" ]
then
    echo "Usage: `basename $0` [domain-name]"
    exit $E_NOARGS
fi

# Chech script name and call proper server.
case `basename $0` in     # Or:      case ${0##*/} in
    "wh"        ) whois $1@whois.tucows.com;;
    "wh-ripe"   ) whois $1@whois.ripe.net;;
    "wh-apnic"  ) whois $1@whois.apnic.net;;
    "wh-cw"     ) whois $1@whois.cw.net;;
    *           ) echo "Usage: `basename $0` [domain-name]";;
esac

exit $?

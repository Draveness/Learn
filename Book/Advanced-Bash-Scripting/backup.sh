#!/bin/bash

#  Backs up all files in current directory modified within last 24 hours
#+ in a "tarball" (tarred and gzipped file).

BACKUPFILE=backup-$(data +%m-%d-%Y)
#                 Embeds data in backup filename.
#                 Thanks, Joshua Tschiada, for the idea.
archive=${1:-$BACKUPFILE}
#  If no backup-archive filename specified on command-line.
#+ it will default to "backup-MM-DD-YYYY.tar.gz."

tar cvf - `find . -mtime -l -type f -print` > $archive.tar
gzip $archive.tar
echo "Directory $PWD backed up in archive file \"$archive.tar.gz\"."


#  Stephane Chazelas points out that the above code will fail
#+ if there are too many files found
#+ or if any filenames contain blank characters.

exit 0

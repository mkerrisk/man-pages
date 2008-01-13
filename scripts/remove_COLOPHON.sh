#!/bin/sh
#
# remove_COLOPHON.sh
#
# Remove the COLOPHON section from the man pages provided as
# command-line arguments.  (This is useful to remove the COLOPHON
# sections from all of the man pages in two different release trees
# in order to do a "diff -ruN" to see the "real" differences between
# the trees.)
#
for f in "$@"; do
    sed -i '/^\.SH COLOPHON/,$d' "$f"
done

#!/bin/sh
#
# A simple script for finding instances of repeated consecutive words
# in manual pages -- human inspection can then determine if these
# are real errors in the text.
#
# Usage: sh find_repeated_words.sh [file...]
#

for file in "$@" ; do 
    words=$(MANWIDTH=2000 man -l "$file" 2> /dev/null | col -b | \
	tr ' \008' '\012' | sed -e '/^$/d' | \
	sed 's/ *$//' | 
	awk 'BEGIN {p=""} {if (p==$0) print p; p=$0}' | \
	grep '[a-zA-Z]' | tr '\012' ' ')
    if test -n "$words"; then
        echo "$file: $words"
    fi
done

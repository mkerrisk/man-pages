#!/bin/sh
#
# Render man pages with FIXMEs shown as tables
# in the rendered page
#
for f in $*; do
    cat $f | awk '
        /^\.\\\" *FIXME/ {
            if ($0 ~ /.*FIXME *\..*/) {
		# FIXMES of the form "FIXME ." are "private" and 
		# ignored by this script
            } else {
                sub("FIXME[: ]*", "")
		if ($0 ~ /^\.\\\"[ 	]*$/) {

		    # If the FIXME line contains no additional text after
		    # "FIXME", then discard the blank line

		    getline
	        }
                print ""
                if (fixme == 0) {
                    print ".TS"
                    print ".allbox;"
                    print "lbw52"
                    print "l."
                    print "FIXME"
                    print "T{"
                }
                fixme = 1
            }
        }

        $0 !~ /^\.\\\"/ && fixme == 1 {
            fixme = 0
            print "T}"
            print ".TE"
            print ""
        }

        fixme == 1 {
	    sub("^\\...[ ]", "")
	    sub("^\\...", "")
	    gsub("'"'"'", "\\(aq")
            if ($0 ~ /^[ 	][ 	]*.*/) {
                print ".br"
                sub("^[ 	]*", "    ")
            }
        }

        {
	    print $0
        }
    ' | tee "/tmp/$(basename $f).src" | man -l /dev/stdin
done

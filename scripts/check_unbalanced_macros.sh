#!/bin/bash
#
# check_unbalanced_macros.sh
#
# Dec 2007, Michael Kerrisk
#
# Look for unbalanced pairs of macros in man page source files, with
# $1 and $2 specifying the macro pair.  These arguments should
# _not_ include the leading dot (.) in the macro.
# As output, the program prints the line numbers containing each macro,
# and if an unbalanced macro is detected, the string "UNBALANCED!"
# is printed.
#
# Example usage:
#
#     sh check_unbalanced_macros.sh nf fi */*.[1-8]
#     sh check_unbalanced_macros.sh RS RE */*.[1-8]
#     sh check_unbalanced_macros.sh EX EE */*.[1-8]
#
######################################################################
#
# (C) Copyright 2020, Michael Kerrisk
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details
# (http://www.gnu.org/licenses/gpl-2.0.html).
#

if test $# -lt 4; then
    echo "Usage: $0 opener closer pages..."
    exit 1
fi

opener="$1"
closer="$2"
shift 2

for f in $@; do
    if egrep "^\.($opener|$closer)" $f > /dev/null; then
        echo "================== $f"

        nl -ba $f |
            awk 'BEGIN { level = 0 }

                 $2 == "'".$opener"'" { level++ }

                 $2 == "'".$opener"'" || $2 == "'".$closer"'" { 
                     printf "%s %s %d", $1, $2, level
                     if (level == 0)
                         print " UNBALANCED!" 
                     else
                         print ""
                 }

                 $2 == "'".$closer"'" { level-- }

                 END { 
                     if (level != 0) 
                         print "UNBALANCED!" 
                 }'
    fi
done

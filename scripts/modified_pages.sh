#!/bin/bash

## SPDX-License-Identifier: GPL-2.0-only
########################################################################
##
## (C) Copyright 2020, Alejandro Colomar
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; version 2.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details
## (http://www.gnu.org/licenses/gpl-2.0.html).
##
########################################################################
##
## The output of this script is a
## list of all files with changes staged for commit
## (basename only if the files are within "man?/"),
## separated by ", ".
## Usage:
## git commit -m "$(./scripts/modified_pages.sh): Short message here"
##


git status							\
|sed "/Changes not staged for commit:/q"			\
|grep -E "^\s*(modified|deleted|new file):"			\
|sed "s/^.*:\s*/, /"						\
|sed "s%man[1-9]/%%"						\
|tr -d '\n'							\
|sed "s/^, //"

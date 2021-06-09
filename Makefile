########################################################################
# Copyright (C) 2021        Alejandro Colomar <alx.manpages@gmail.com>
# SPDX-License-Identifier:  GPL-2.0  OR  LGPL-2.0
########################################################################
# Conventions:
#
# - Follow "Makefile Conventions" from the "GNU Coding Standards" closely.
#   However, when something could be improved, don't follow those.
# - Uppercase variables, when referring files, refer to files in this repo.
# - Lowercase variables, when referring files, refer to system files.
# - Variables starting with '_' refer to absolute paths, including $(DESTDIR).
# - Variables ending with '_' refer to a subdir of their parent dir, which
#   is in a variable of the same name but without the '_'.  The subdir is
#   named after this project: <*/man>.
# - Variables ending in '_rm' refer to files that can be removed (exist).
# - Variables ending in '_rmdir' refer to dirs that can be removed (exist).
# - Targets of the form '%-rm' remove their corresponding file '%'.
# - Targets of the form '%/.-rmdir' remove their corresponding dir '%/'.
# - Targets of the form '%/.' create their corresponding directory '%/'.
# - Every file or directory to be created depends on its parent directory.
#   This avoids race conditions caused by `mkdir -p`.  Only the root
#   directories are created with parents.
# - The 'FORCE' target is used to make phony some variables that can't be
#   .PHONY to avoid some optimizations.
#
########################################################################

MAKEFLAGS += --no-print-directory
MAKEFLAGS += --silent
MAKEFLAGS += --warn-undefined-variables


htmlbuilddir := $(CURDIR)/.html
HTOPTS :=

DESTDIR :=
prefix := /usr/local
datarootdir := $(prefix)/share
docdir := $(datarootdir)/doc
MANDIR := $(CURDIR)
mandir := $(datarootdir)/man
MAN1DIR := $(MANDIR)/man1
MAN2DIR := $(MANDIR)/man2
MAN3DIR := $(MANDIR)/man3
MAN4DIR := $(MANDIR)/man4
MAN5DIR := $(MANDIR)/man5
MAN6DIR := $(MANDIR)/man6
MAN7DIR := $(MANDIR)/man7
MAN8DIR := $(MANDIR)/man8
man1dir := $(mandir)/man1
man2dir := $(mandir)/man2
man3dir := $(mandir)/man3
man4dir := $(mandir)/man4
man5dir := $(mandir)/man5
man6dir := $(mandir)/man6
man7dir := $(mandir)/man7
man8dir := $(mandir)/man8
manext := \.[0-9]
man1ext := .1
man2ext := .2
man3ext := .3
man4ext := .4
man5ext := .5
man6ext := .6
man7ext := .7
man8ext := .8
htmldir := $(docdir)
htmldir_ := $(htmldir)/man
htmlext := .html

INSTALL := install
INSTALL_DATA := $(INSTALL) -m 644
INSTALL_DIR := $(INSTALL) -m 755 -d
RM := rm
RMDIR := rmdir --ignore-fail-on-non-empty

MAN_SECTIONS := 1 2 3 4 5 6 7 8


.PHONY: all
all:
	$(MAKE) uninstall
	$(MAKE) install


%/.:
	$(info -	INSTALL	$(@D))
	$(INSTALL_DIR) $(@D)

%-rm:
	$(info -	RM	$*)
	$(RM) $*

%-rmdir:
	$(info -	RMDIR	$(@D))
	$(RMDIR) $(@D)


.PHONY: install
install: install-man | installdirs
	@:

.PHONY: installdirs
installdirs: | installdirs-man
	@:

.PHONY: uninstall remove
uninstall remove: uninstall-man
	@:

.PHONY: clean
clean:
	find man?/ -type f \
	|while read f; do \
		rm -f "$(htmlbuilddir)/$$f".*; \
	done;

########################################################################
# man

MANPAGES   := $(sort $(shell find $(MANDIR)/man?/ -type f | grep '$(manext)$$'))
_manpages  := $(patsubst $(MANDIR)/%,$(DESTDIR)$(mandir)/%,$(MANPAGES))
_man1pages := $(filter %$(man1ext),$(_manpages))
_man2pages := $(filter %$(man2ext),$(_manpages))
_man3pages := $(filter %$(man3ext),$(_manpages))
_man4pages := $(filter %$(man4ext),$(_manpages))
_man5pages := $(filter %$(man5ext),$(_manpages))
_man6pages := $(filter %$(man6ext),$(_manpages))
_man7pages := $(filter %$(man7ext),$(_manpages))
_man8pages := $(filter %$(man8ext),$(_manpages))

MANDIRS  := $(sort $(shell find $(MANDIR)/man? -type d))
_mandirs := $(patsubst $(MANDIR)/%,$(DESTDIR)$(mandir)/%/.,$(MANDIRS))
_man1dir := $(filter %man1/.,$(_mandirs))
_man2dir := $(filter %man2/.,$(_mandirs))
_man3dir := $(filter %man3/.,$(_mandirs))
_man4dir := $(filter %man4/.,$(_mandirs))
_man5dir := $(filter %man5/.,$(_mandirs))
_man6dir := $(filter %man6/.,$(_mandirs))
_man7dir := $(filter %man7/.,$(_mandirs))
_man8dir := $(filter %man8/.,$(_mandirs))
_mandir  := $(DESTDIR)$(mandir)/.

_manpages_rm  := $(addsuffix -rm,$(wildcard $(_manpages)))
_man1pages_rm := $(filter %$(man1ext)-rm,$(_manpages_rm))
_man2pages_rm := $(filter %$(man2ext)-rm,$(_manpages_rm))
_man3pages_rm := $(filter %$(man3ext)-rm,$(_manpages_rm))
_man4pages_rm := $(filter %$(man4ext)-rm,$(_manpages_rm))
_man5pages_rm := $(filter %$(man5ext)-rm,$(_manpages_rm))
_man6pages_rm := $(filter %$(man6ext)-rm,$(_manpages_rm))
_man7pages_rm := $(filter %$(man7ext)-rm,$(_manpages_rm))
_man8pages_rm := $(filter %$(man8ext)-rm,$(_manpages_rm))

_mandirs_rmdir := $(addsuffix -rmdir,$(wildcard $(_mandirs)))
_man1dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man1dir)))
_man2dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man2dir)))
_man3dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man3dir)))
_man4dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man4dir)))
_man5dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man5dir)))
_man6dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man6dir)))
_man7dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man7dir)))
_man8dir_rmdir := $(addsuffix -rmdir,$(wildcard $(_man8dir)))
_mandir_rmdir  := $(addsuffix -rmdir,$(wildcard $(_mandir)))

install_manX     := $(foreach x,$(MAN_SECTIONS),install-man$(x))
installdirs_manX := $(foreach x,$(MAN_SECTIONS),installdirs-man$(x))
uninstall_manX   := $(foreach x,$(MAN_SECTIONS),uninstall-man$(x))


.SECONDEXPANSION:
$(_manpages): $(DESTDIR)$(mandir)/man%: $(MANDIR)/man% | $$(@D)/.
	$(info -	INSTALL	$@)
	$(INSTALL_DATA) -T $< $@

$(_mandirs): %/.: | $$(dir %). $(_mandir)

$(_mandirs_rmdir): $(DESTDIR)$(mandir)/man%/.-rmdir: $$(_man%pages_rm) FORCE
$(_mandir_rmdir): $(uninstall_manX) FORCE


.PHONY: $(install_manX)
$(install_manX): install-man%: $$(_man%pages) | installdirs-man%
	@:

.PHONY: install-man
install-man: $(install_manX)
	@:

.PHONY: $(installdirs_manX)
$(installdirs_manX): installdirs-man%: $$(_man%dir) $(_mandir)
	@:

.PHONY: installdirs-man
installdirs-man: $(installdirs_manX)
	@:

.PHONY: $(uninstall_manX)
$(uninstall_manX): uninstall-man%: $$(_man%pages_rm) $$(_man%dir_rmdir)
	@:

.PHONY: uninstall-man
uninstall-man: $(_mandir_rmdir) $(uninstall_manX)
	@:


########################################################################
# html

# Use with
#  make HTOPTS=whatever html
# The sed removes the lines "Content-type: text/html\n\n"
.PHONY: html
html: | builddirs-html
	find man?/ -type f \
	|while read f; do \
		man2html $(HTOPTS) "$$f" \
		|sed -e '1,2d' \
		>"$(htmlbuilddir)/$${f}$(htmlext)" \
			|| exit $$?; \
	done;

.PHONY: builddirs-html
builddirs-html:
	find man?/ -type d \
	|while read d; do \
		$(INSTALL_DIR) "$(htmlbuilddir)/$$d" || exit $$?; \
	done;

.PHONY: install-html
install-html: | installdirs-html
	cd $(htmlbuilddir) && \
	find man?/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -T "$$f" "$(DESTDIR)$(htmldir_)/$$f" || exit $$?; \
	done;

.PHONY: installdirs-html
installdirs-html:
	find man?/ -type d \
	|while read d; do \
		$(INSTALL_DIR) "$(DESTDIR)$(htmldir_)/$$d" || exit $$?; \
	done;

.PHONY: uninstall-html
uninstall-html:
	find man?/ -type f \
	|while read f; do \
		rm -f "$(DESTDIR)$(htmldir_)/$$f".* || exit $$?; \
	done;


########################################################################
# tests

# Check if groff reports warnings (may be words of sentences not displayed)
# from https://lintian.debian.org/tags/groff-message.html
.PHONY: check-groff-warnings
check-groff-warnings:
	GROFF_LOG="$$(mktemp --tmpdir manpages-checksXXXX)" || exit $$?; \
	for i in man?/*.[1-9]; \
	do \
		if grep -q 'SH.*NAME' "$$i"; then \
			LC_ALL=en_US.UTF-8 MANWIDTH=80 man --warnings -E UTF-8 -l "$$i" > /dev/null 2>| "$$GROFF_LOG"; \
			[ -s "$$GROFF_LOG" ] && { echo "$$i: "; cat "$$GROFF_LOG"; echo; }; \
		fi; \
	done; \
	rm -f "$$GROFF_LOG"

# someone might also want to look at /var/catman/cat2 or so ...
# a problem is that the location of cat pages varies a lot

########################################################################

FORCE:

#!/usr/bin/make -f

# Do not print "Entering directory ..."
MAKEFLAGS += --no-print-directory

htmlbuilddir = $(CURDIR)/.html
HTOPTS =

DESTDIR =
prefix = /usr/local
datarootdir = $(prefix)/share
docdir = $(datarootdir)/doc
mandir = $(datarootdir)/man
htmldir = $(docdir)
htmldir_ = $(htmldir)/man
htmlext = .html

INSTALL = install
INSTALL_DATA = $(INSTALL) -m 644
INSTALL_DIR = $(INSTALL) -m 755 -d

.PHONY: all
all: remove install

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

.PHONY: install
install: | installdirs
	find man?/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -T "$$f" "$(DESTDIR)$(mandir)/$$f" || exit $$?; \
	done;

.PHONY: installdirs
installdirs:
	find man?/ -type d \
	|while read d; do \
		$(INSTALL_DIR) "$(DESTDIR)$(mandir)/$$d" || exit $$?; \
	done;

.PHONY: uninstall remove
uninstall remove:
	find man?/ -type f \
	|while read f; do \
		rm -f "$(DESTDIR)$(mandir)/$$f" || exit $$?; \
		rm -f "$(DESTDIR)$(mandir)/$$f".* || exit $$?; \
	done;

.PHONY: uninstall-html
uninstall-html:
	find man?/ -type f \
	|while read f; do \
		rm -f "$(DESTDIR)$(htmldir_)/$$f".* || exit $$?; \
	done;

.PHONY: clean
clean:
	find man?/ -type f \
	|while read f; do \
		rm -f "$(htmlbuilddir)/$$f".* || exit $$?; \
	done;

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

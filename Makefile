DESTDIR=
prefix?=/usr
MANDIR=$(prefix)/share/man

all: remove install

uninstall remove:
	for i in man?/*; do \
		rm -f $(MANDIR)/"$$i" $(MANDIR)/"$$i".*; \
	done

# Use with
#  make HTDIR=/some/dir HTOPTS=whatever html
# The sed removes the lines "Content-type: text/html\n\n"
html:
	@if [ x$(HTDIR) = x ]; then echo "You must set HTDIR."; else \
	for i in man?; do \
		[ -d $(HTDIR)/"$$i" ] || mkdir -p $(HTDIR)/"$$i"; \
		find "$$i/" -type f | while read f; do \
			(cd "$$i"; man2html $(HTOPTS) `basename $$f`) | \
			sed -e '1,2d' > $(HTDIR)/"$$i"/`basename $$f`.html; \
		done; \
	done; fi

install:
	for i in man?; do \
		install -d -m 755 $(DESTDIR)$(MANDIR)/"$$i" || exit $$?; \
		install -m 644 "$$i"/* $(DESTDIR)$(MANDIR)/"$$i" || exit $$?; \
	done

# Check if groff reports warnings (may be words of sentences not displayed)
# from http://lintian.debian.org/tags/manpage-has-errors-from-man.html
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

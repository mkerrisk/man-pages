# Do "make screen" first, if you want to protect already installed,
# more up-to-date manual pages than the ones included in this package.
# Do "make install" to copy the pages to their destination.
# Do "make gz" or "make bz2" first if you use compressed source pages.

MANDIR=$(prefix)/usr/share/man

GZIP=gzip -9
BZIP2=bzip2 -9

all: screen remove install

allgz: gz all

allbz: bz2 all

screen:
	-mkdir not_installed
	for i in man?/*; do \
		if [ $(MANDIR)/"$$i" -nt "$$i" ]; then \
			cmp -s $(MANDIR)/"$$i" "$$i" > /dev/null 2>&1; \
			if [ "$$?" != 0 ]; then mv "$$i" not_installed; fi; \
		fi; \
	done

remove:
	for i in man?/* man??/*; do \
		rm -f $(MANDIR)/"$$i" $(MANDIR)/"$$i".gz $(MANDIR)/"$$i".bz2; \
	done

gz:
	for i in man? man??; do $(GZIP) "$$i"/*; done

bz2:
	for i in man? man??; do $(BZIP2) "$$i"/*; done

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

README=$(MANDIR)/man1/README
install:
	for i in man? man??; do \
		install -d -m 755 $(MANDIR)/"$$i"; \
		install -m 644 "$$i"/* $(MANDIR)/"$$i"; \
	done; \
	rm -f $(README) $(README).gz $(README).bz2

# someone might also want to look at /var/catman/cat2 or so ...
# a problem is that the location of cat pages varies a lot

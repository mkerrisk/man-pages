.\"  Copyright 2003 walter harms (walter.harms@informatik.uni-oldenburg.de)
.\"
.\" %%%LICENSE_START(GPL_NOVERSION_ONELINE)
.\"  Distributed under GPL
.\" %%%LICENSE_END
.\"
.\"  this is the 3rd type of interface for cryptographic routines
.\"  1. encrypt() expects a bit field
.\"  2. cbc_crypt() byte values
.\"  3. xencrypt() a hexstring
.\"  to bad to be true :(
.\"
.TH XCRYPT 3 2021-03-22 "" "Linux Programmer's Manual"
.SH NAME
xencrypt, xdecrypt, passwd2des \- RFS password encryption
.SH SYNOPSIS
.nf
.B "#include <rpc/des_crypt.h>"
.PP
.BI "void passwd2des(char " *passwd ", char *" key ");"
.PP
.BI "int xencrypt(char *" secret ", char *" passwd ");"
.BI "int xdecrypt(char *" secret ", char *" passwd ");"
.fi
.SH DESCRIPTION
.BR WARNING :
Do not use these functions in new code.
They do not achieve any type of acceptable cryptographic security guarantees.
.PP
The function
.BR passwd2des ()
takes a character string
.I passwd
of arbitrary length and fills a character array
.I key
of length 8.
The array
.I key
is suitable for use as DES key.
It has odd parity set in bit 0 of each byte.
Both other functions described here use this function to turn their
argument
.I passwd
into a DES key.
.PP
The
.BR xencrypt ()
function takes the ASCII character string
.I secret
given in hex,
.\" (over the alphabet 0123456789abcdefABCDEF),
which must have a length that is a multiple of 16,
encrypts it using the DES key derived from
.I passwd
by
.BR passwd2des (),
and outputs the result again in
.I secret
as a hex string
.\" (over the alphabet 0123456789abcdef)
of the same length.
.PP
The
.BR xdecrypt ()
function performs the converse operation.
.SH RETURN VALUE
The functions
.BR xencrypt ()
and
.BR xdecrypt ()
return 1 on success and 0 on error.
.SH VERSIONS
These functions are available in glibc since version 2.1.
.SH ATTRIBUTES
For an explanation of the terms used in this section, see
.BR attributes (7).
.ad l
.nh
.TS
allbox;
lbx lb lb
l l l.
Interface	Attribute	Value
T{
.BR passwd2des (),
.BR xencrypt (),
.BR xdecrypt ()
T}	Thread safety	MT-Safe
.TE
.hy
.ad
.sp 1
.SH BUGS
The prototypes are missing from the abovementioned include file.
.SH SEE ALSO
.BR cbc_crypt (3)

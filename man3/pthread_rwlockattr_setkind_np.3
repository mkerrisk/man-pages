.\"Copyright (c) 2010 Novell Inc., written by Robert Schweikert
.\"
.\" %%%LICENSE_START(VERBATIM)
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\" %%%LICENSE_END
.\"
.TH PTHREAD_RWLOCKATTR_SETKIND_NP 3 2021-03-22 "Linux Programmer's Manual"
.SH NAME
pthread_rwlockattr_setkind_np, pthread_rwlockattr_getkind_np \- set/get
the read-write lock kind of the thread read-write lock attribute object
.SH SYNOPSIS
.nf
.B #include <pthread.h>
.PP
.BI "int pthread_rwlockattr_setkind_np(pthread_rwlockattr_t *" attr ,
.BI "                       int " pref );
.BI "int pthread_rwlockattr_getkind_np("
.BI "                       const pthread_rwlockattr_t *restrict " attr ,
.BI "                       int *restrict " pref );
.PP
Compile and link with \fI\-pthread\fP.
.PP
.fi
.RS -4
Feature Test Macro Requirements for glibc (see
.BR feature_test_macros (7)):
.RE
.PP
.BR pthread_rwlockattr_setkind_np (),
.BR pthread_rwlockattr_getkind_np ():
.nf
    _XOPEN_SOURCE >= 500 || _POSIX_C_SOURCE >= 200809L
.fi
.SH DESCRIPTION
The
.BR pthread_rwlockattr_setkind_np ()
function sets the "lock kind" attribute of the
read-write lock attribute object referred to by
.I attr
to the value specified in
.IR pref .
The argument
.I pref
may be set to one of the following:
.TP
.B PTHREAD_RWLOCK_PREFER_READER_NP
This is the default.
A thread may hold multiple read locks; that is, read locks are recursive.
According to The Single Unix Specification, the behavior is unspecified when a
reader tries to place a lock, and there is no write lock but writers are
waiting.
Giving preference to the reader, as is set by
.BR PTHREAD_RWLOCK_PREFER_READER_NP ,
implies that the reader will receive the requested lock, even if
a writer is waiting.
As long as there are readers, the writer will be
starved.
.TP
.B PTHREAD_RWLOCK_PREFER_WRITER_NP
This is intended as the write lock analog of
.BR PTHREAD_RWLOCK_PREFER_READER_NP .
This is ignored by glibc because the POSIX requirement to support
recursive read locks would cause this option to create trivial
deadlocks; instead use
.B PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP
which ensures the application developer will not take recursive
read locks thus avoiding deadlocks.
.\" ---
.\" Here is the relevant wording:
.\"
.\"     A thread may hold multiple concurrent read locks on rwlock (that is,
.\"     successfully call the pthread_rwlock_rdlock() function n times). If
.\"     so, the thread must perform matching unlocks (that is, it must call
.\"     the pthread_rwlock_unlock() function n times).
.\"
.\" By making write-priority work correctly, I broke the above requirement,
.\" because I had no clue that recursive read locks are permissible.
.\"
.\" If a thread which holds a read lock tries to acquire another read lock,
.\" and now one or more writers is waiting for a write lock, then the algorithm
.\" will lead to an obvious deadlock. The reader will be suspended, waiting for
.\" the writers to acquire and release the lock, and the writers will be
.\" suspended waiting for every existing read lock to be released.
.\" ---
.\" https://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_rwlock_rdlock.html
.\" https://sourceware.org/legacy-ml/libc-alpha/2000-01/msg00055.html
.\" https://sourceware.org/bugzilla/show_bug.cgi?id=7057
.TP
.B PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP
Setting the lock kind to this
avoids writer starvation as long as any read locking is not done in a
recursive fashion.
.PP
The
.BR pthread_rwlockattr_getkind_np ()
function returns the value of the lock kind attribute of the
read-write lock attribute object referred to by
.IR attr
in the pointer
.IR pref .
.SH RETURN VALUE
On success, these functions return 0.
Given valid pointer arguments,
.BR pthread_rwlockattr_getkind_np ()
always succeeds.
On error,
.BR pthread_rwlockattr_setkind_np ()
returns a nonzero error number.
.SH ERRORS
.TP
.BR EINVAL
.I pref
specifies an unsupported value.
.SH VERSIONS
The
.BR pthread_rwlockattr_getkind_np ()
and
.BR pthread_rwlockattr_setkind_np ()
functions first appeared in glibc 2.1.
.SH CONFORMING TO
These functions are non-standard GNU extensions;
hence the suffix "_np" (nonportable) in the names.
.SH SEE ALSO
.BR pthreads (7)

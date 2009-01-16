#!/usr/local/bin/perl -w

use strict;
use Fcntl;
use TDB_File;

# $Id: dump.pl,v 1.3 2007-07-12 07:52:14 adrian Exp $

my ($dstfile) = $ARGV[0];

my (%db);
tie %db, 'TDB_File', $dstfile, TDB_DEFAULT, O_RDONLY, 0644 || die "Couldn't open $dstfile: $!\n";

foreach (keys %db) {
	print "$_\n  $db{$_}\n";
}
untie %db;



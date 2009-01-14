#!/usr/bin/perl -w

#
# This is a very simple URL rewriter!
#
# Adrian Chadd <adrian@xenion.com.au>
#

# History:
# - 2008/12/16 - initial revision

use strict;
use IO::File;

# Disable output buffering
$| = 1;

my (@pats);
my ($do_debug) = 0;

# Load in patterns

my ($fh) = new IO::File;
$fh->open($ARGV[0], "r") || die "couldn't read redirect list: $!\n";
shift @ARGV;

while (my $line = <$fh>) {
	chomp $line;
	# print "Got: $line\n";
	next if $line =~ /^#/;
	next if $line =~  /^$/;

	# Lines are either;
	# ~<allow pattern>
	# <pattern> <substitute>

	if ($line =~ m/^\~(.*)$/) {
		my ($r) = {};
		$r->{"pattern"} = $1;
		$r->{"action"} = "allow";
		$r->{"sub"} = "";
		push @pats, $r;
		print STDERR "Added: ALLOW:" . $1 . "\n" if $do_debug;
	} else {
		my (@s) = split(/ /, $line);
		my ($r) = {};
		$r->{"pattern"} = $s[0];
		$r->{"action"} = "substitute";
		$r->{"sub"} = $s[1];
		push @pats, $r;
		print STDERR "Added: SUB:" . $s[0] . " -> " . $s[1] . "\n" if $do_debug;
	}
}

sub match_url($$) {
	my ($pats, $url) = @_;

	foreach (@$pats) {
		my ($r) = $_;
		if ($url =~ m/($r->{"pattern"})/) {
			if ($r->{"action"} eq "allow") {
				print STDERR "MATCH: ALLOW: $url\n" if $do_debug;
				print $url . "\n";
				return;
			} else {
				print STDERR "MATCH: SUBSTITUTE: $url -> " . $r->{"sub"} . "\n" if $do_debug;
				print $r->{"sub"} . "\n";
				return;
			}
		}
	}
	print STDERR "NOMATCH: $url\n" if $do_debug;
	print $url . "\n";
}

# The URL is the first part of the redirector line, up to the first space
while (<>) {
	chomp;
	my (@s) = split(/ /);
	if (! defined $s[0]) {
		print "\n";		# Return a blank line if one is given
	} else {
		match_url(\@pats, $s[0]);
	}
}

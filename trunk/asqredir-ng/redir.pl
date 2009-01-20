#!/usr/bin/perl -w

#
# This is a very simple URL rewriter!
#
# Adrian Chadd <adrian@xenion.com.au>
#

# History:
# - 2009/01/20 - Modify regex evaluation to allow substitution strings to use $1, $2, etc.
# - 2008/12/16 - initial revision

use strict;
use IO::File;

# Disable output buffering
$| = 1;

my (@pats);
my ($do_debug) = 1;

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
		my ($s) = "";

		if ($r->{"action"} eq "substitute") {
			$s = '"' . $r->{"sub"} . '"';
		}
		my ($nurl) = $url;
		# /e means "treat the substitution as something to evaluate
		# just one e doesn't properly evaluate the string; it turns out what
		# you need to do is wrap it in single quotes so it doesn't quote escape it
		# for you (then $1 is interpreted as a literal, not something to substitute
		# into!) and the second seems to remove the quotes, evaluating the string.
		if ($nurl =~ s/$r->{"pattern"}/$s/ee) {
			if ($r->{"action"} eq "allow") {
				print STDERR "MATCH: ALLOW: $url\n" if $do_debug;
				print $url . "\n";
				return;
			} else {
				print STDERR "MATCH: SUBSTITUTE: $url -> " . $nurl . "\n" if $do_debug;
				print $nurl . "\n";
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

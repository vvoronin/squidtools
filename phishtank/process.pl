#!/usr/local/bin/perl -w

use strict;
use Fcntl;
use XML::Twig;
use TDB_File;

# $Id: process.pl,v 1.3 2007-07-12 07:52:14 adrian Exp $

if (scalar @ARGV < 2) {
	print "Usage: process.pl <source xml> <destination db>\n";
	exit 1;
}

my ($srcfile) = $ARGV[0];
my ($dstfile) = $ARGV[1];

my ($entries) = 0;

my (%db);
tie %db, 'TDB_File', $dstfile . ".new", TDB_DEFAULT, O_TRUNC | O_CREAT | O_RDWR, 0644 || die "Couldn't open $dstfile: $!\n";

my $twig = new XML::Twig(TwigHandlers => { entry => \&extract, meta => \&header });
$twig->parsefile($srcfile);
untie %db;
undef %db;
print "Process successful: Total entries: $entries\n";
rename $dstfile . ".new", $dstfile || die "Couldn't rename replacement database to $dstfile: $!\n";
exit 0;

sub header {
	my ($t, $entry) = @_;

	my ($genstamp);
	my ($total);

	$genstamp = $entry->field("generated_at");
	$total = $entry->field("total_entries");
	print "HEADER: Timestamp $genstamp; Total Entries $total\n";
};

sub extract {
	my ($t, $entry) = @_;

	# url, phish_id, phish_detail_url

	my ($url) = $entry->field("url") . "\n";
	my ($phish_url) = $entry->field("phish_detail_url") . "\n";
	chomp $url;
	chomp $phish_url;

	# print "$url\n$phish_url\n";
	$db{$url} = $phish_url;
	$entries++;
};

#!/usr/bin/env perl
use utf8;
use strict;
use warnings;

my $delegated=$ARGV[0];
my $dir=$ARGV[1];

my %cidr;
foreach(1..32) { $cidr{ 2 ** $_ }=32-$_ }

my %country;
open(my $fh,'<:utf8',$delegated) || die $!;
foreach(<$fh>) {
	chomp;
	if(/^apnic\|([A-Z]{2})\|ipv4\|([0-9\.]+)\|(\d+)\|(\d+)\|allocated$/) {
		$country{$1}||=[];
		push @{$country{$1}},"$2/$cidr{$3}";
	}
}

while(my($ct,$ip)=each %country) {
	open(my $fh,'>:utf8',"$dir/$ct") || die $!;
	foreach(@{$ip}) { print $fh "$_\n" }
}


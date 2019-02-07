#!/usr/bin/env perl
use utf8;
use strict;
use warnings;

my $dir=shift @ARGV;
my $dev=shift @ARGV;
my @countries=@ARGV;

{
	my @buf=();
	push @buf,'*filter';

	foreach my $country (@countries) {
		my $filename=sprintf('%s/%s',$dir,$country);
		open(my $fh,'<',$filename) || die "$filename - $!";
		foreach(<$fh>) {
			chomp;
			push @buf,"-A INPUT -i $dev -s $_ -j COUNTRY_$country";
		}
	}

	push @buf,'COMMIT';
	foreach(@buf) { print "$_\n" }
}

# open(my $fh,"| iptables-restore --verbose --noflush") || die $!;


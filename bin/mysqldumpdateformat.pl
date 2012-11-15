#!/usr/local/wu/bin/perl
use Getopt::Long;
use Tie::File;
use Date::Manip
GetOptions( "f=s" => \$importfile); # -f=/path/file.txt
tie @mydata, 'Tie::File', $importfile or die "error opening $importfile";

foreach $m (@mydata) {
	# 2008-11-13 14:06:43
	if ( $m =~ m|\"(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})\"| ){
		$dated = "$1$2$3$4$5$6";
#		print "$dated"
        $m =~ s|\"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\"|\"$dated\"|g;
	}
	print "$m\n";	
}

#!/usr/local/wu/bin/perl
use Getopt::Long;
#use Tie::File;
use File::Slurp;
GetOptions( "f=s" => \$firstFile, # -f=/path/file.txt
            "l=s" => \$secondFile); # -l=/path/file2.txt 
#tie @myFirst, 'Tie::File', $firstFile or die "error opening $firstFile";
#tie @mySecond, 'Tie::File', $secondFile or die "error opening $secondFile";
my $myFirst = read_file($firstFile);
my $mySecond = read_file($secondFile);

@firstChunks = split(/^(?=\.FAILED.*$)/m,$myFirst);
@secondChunks = split(/^(?=\.FAILED.*$)/m,$mySecond);

#my %seen;
#my @filtered = grep !$seen{$-}++, @secondChunks;

my %seen = map + ($_ => 1), @firstChunks;
@secondChunks = grep !$firstChunks{$$_[0]}, @secondChunks;
@secondChunks = grep {my $second = $$_[0]; not grep $_ eq $second, @firstChunks} @secondChunks;

foreach $m (@secondChunks) {
	print "$m\n\n\n\n\n";
}

#while ($myFirst =~ m|(^FAILED.*Error\sMessage.*Stack\sTrace.*)^\s+$^\s+$|g) {
#  print "File $myFirst\n\n\n";
#while ($myFirst =~ m|^(FAILED.*)^\s+$^\s+|gis) {
#	$testResult = $1;
#	print "Test Result $testResult";
#}

#foreach $m (@myFirst) {
#	
#	if ($errorMessage) {
#		
#	}
#
#	if ( $m =~ m|^FAILED...(.*)| ) {
#		$testName = "$1";
#	    print "Test Name: $testName\n";	
#	}
#
#	if ( $m =~ m|^Error\sMessage| ) {
#		$errorMessage = true;
#	}	
#
#	if ( $m =~ m|^Stack\sTrace| ) {
#		$stackTrace = true;
#	}	
#}


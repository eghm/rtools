#!/usr/local/wu/bin/perl
use Getopt::Long;
use Tie::File;
use File::Slurp;
use Date::Manip
GetOptions( "f=s" => \$importdir); # -f=/path/
opendir(DIR, $importdir);

my @filelist;
foreach my $file (readdir(DIR)) {
    if ($file =~ m|.*AbstractSmokeTestBase\.java$|s) {
        print "file: $file\n";
        push(@filelist, $file);
    }
}

closedir(DIR);

foreach my $importfile (@filelist) {
    tie @mydata, 'Tie::File', $importfile or die "error opening $importfile";
    my $i = 0;
	foreach $m (@mydata) {
		if ($m =~ m|public abstract class|) {
            @mydata[$i] =~ s|public abstract class|public class|;
            print "@mydata[$i]\n";
		}

		if @mydata[$i] =~ m|AbstractSmokeTestBase|) {
            @mydata[$i] =~ s|AbstractSmokeTestBase|SmokeTest|;
            print "@mydata[$i]\n";
		}

		if @mydata[$i] =~ m|AbstractSmokeTestBase|) {
            @mydata[$i] =~ s|AbstractSmokeTestBase|SmokeTest|;
            print "@mydata[$i]\n";
		}

		$i++;
	}
}


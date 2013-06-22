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
        #print "file: $file\n";
        push(@filelist, $file);
    }
}

closedir(DIR);

foreach my $importfile (@filelist) {
    my @tests;

    print "processing $importfile\n";
    #`rm $importfile.properties`;

	my $package = `grep "^package" $importdir/$importfile`;
    ($package =~ m|^package\s(\S*);.*|s);
    $package = $1;
	print "package=$package\n";

    # bookmark is often broken up on a few lines, need to read file as one string and grep to the ;
#	my $bookmark = `grep "public static final String BOOKMARK" $importdir/$importfile`;
#    if ($bookmark =~ m|^\s*public\sstatic\sfinal\sString\sBOOKMAR\S*\s*=\s*(.*);.*|s) {
#        $bookmark = $1;
#	    print "bookmark=$bookmark\n";	
#    } else {
#	    my $mydata = read_file("$importdir/$importfile");
#	    if ($mydata =~ m|^.*public\sstatic\sfinal\sString\sBOOKMAR\S*\s*=\s*(.*);.*|g) {
#    	    $bookmark = $1;
#	    } else {
#		    exit;
#	    }
#    }

    my $className;
    ($importfile =~ m|(\S*)Abstrac.*|s);
    $className = $1;
    print "className=$className\n";

    my @testMethods = `grep "public void test" $importdir/$importfile`;
    foreach my $testline (@testMethods) {
        #print "\t$testline\n";

        ($testline =~ m|^\s*public\svoid\s(\S*)\s*\(.*|s);
        my $test = $1;
        #print "\t$test\n";
        if ("$test" ~~ @tests) {
        } else {
            push(@tests, $test);
        }
    }

    @tests = sort(@tests);
    my $testCount = 1;
    foreach my $test (@tests) {
        print "test$testCount=$test\n";
        $testCount += 1;
    }

    print "\n";
}


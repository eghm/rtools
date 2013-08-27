#!/usr/local/wu/bin/perl
# From the directory with all the smoke test logs:
# perl browsertestresults.pl -f=$(pwd) > results.txt
use Getopt::Long;
use Tie::File;
use Date::Manip
GetOptions( "f=s" => \$importdir); # -f=/path/
opendir(DIR, $importdir);

my $imgDir="/r/rtools/img/browsertest";

sub chrome {
	($envLine) = @_;
	my $htmlBit = "";
		
    if ($envLine =~ m|.*\schrome\s|) {
        $htmlBit .= "<img src=\"$imgDir/chrome.png\"><br/>";	
        ($envLine =~ m|.*ff\s(\d*)\s.*|);
        $htmlBit .= "$1";
    }
    return $htmlBit;
}

sub firefox {
	($envLine) = @_;
	my $htmlBit = "";
		
    if ($envLine =~ m|.*\sff\s|) {
        $htmlBit .= "<img src=\"$imgDir/firefox.png\"><br/>";	
        ($envLine =~ m|.*ff\s(\d*)\s.*|);
        $htmlBit .= "$1";
    }
    return $htmlBit;
}

sub ie {
    ($envLine) = @_;
	my $htmlBit = "";

    if ($envLine =~ m|.*\sie\s|) {
        $htmlBit .= "<img src=\"$imgDir/ie.png\"><br/>";	
        ($envLine =~ m|.*ie\s(\d*)\s.*|);
        $htmlBit .= "$1";
    }
	return $htmlBit;
}

sub opera {
    ($envLine) = @_;
	my $htmlBit = "";

    if ($envLine =~ m|.*\sopera\s|) {
        $htmlBit .= "<img src=\"$imgDir/opera.png\"><br/>";	
        ($envLine =~ m|.*opera\s(\d*)\s.*|);
        $htmlBit .= "$1";
    }
	return $htmlBit;
}

sub safari {
    ($envLine) = @_;
	my $htmlBit = "";

    if ($envLine =~ m|.*safari|) {
    	$htmlBit .= "<img src=\"$imgDir/safari.png\"><br/>";	
        ($envLine =~ m|.*safari\s(\d*)|);
        $htmlBit .= "$1";	
    }
	return $htmlBit;
}


my @filelist;
foreach my $file (readdir(DIR)) {
    if ($file =~ m|.*\.out$|s) {
        #print "file: $file\n";
        push(@filelist, $file);
    }
}

closedir(DIR);

my @tests;
foreach my $importfile (@filelist) {
    #print "processing $importfile\n";
    `rm $importfile.results`;
    
    #print "grep \" sessionId is \" $importfile";
    my @testSessionIds = `grep " sessionId is " $importfile`;
    foreach my $testline (@testSessionIds) {
        #print "\t$testline\n";

        ($testline =~ m|^(\S*)\s.*|s);
        my $test = $1;
        #print "\t$test\n";
        if ("$test" ~~ @tests) {
        } else {
            push(@tests, $test);
        }

        ($testline =~ m|^.*\s(.*)\s$|s);
        my $sessionId = $1;
        #print "\t$test $sessionId\n";

        my @sessionIdStates = `grep $sessionId $importfile`;
        foreach my $sessionState (@sessionIdStates) {
            if ($sessionState =~ m|^Registering session.*|s) {
                #print "\t\t$sessionState\n";
                ($sessionState =~ m|^Registering session (\S*) $sessionId|s);
                #print "\t\t\t$1\n";
                my $state = $1;
                `echo $test $state >> $importfile.results`;
            }
        }
    }
}

@tests = sort(@tests);
my $testLengthMax = 0;
foreach my $test (@tests) {
    if (length($test) gt $testLengthMax) {
        $testLengthMax = length($test);
    }
    #print "$test\n";
}


my $header = "<html><head></head><body><table border=\"1\">";
my $headerspace = "    ";;
for ($i = $testLengthMax; $i >= 0; $i--) {
    $headerspace .= " ";
}

my @testenvs;
my $testenvsLengthMax = 0;
foreach my $testenv (@filelist) {
    if ($testenv =~ m|^\S*?\-(.*)\-\d*.*|s) {
        my $envtext = $1;
        (my $envreadable = $envtext) =~ s/_/ /g;
        (my $envreadable2 = $envreadable) =~ s/-/ /g;
        push(@testenvs, $envreadable2);
        if (length($envtext) > $testenvsLengthMax) {
            $testenvsLengthMax = length($envtext);
        }
    }
}


$header .= "<tr><td>" . $headerspace . "</td>";
foreach my $testenv (@testenvs) {
	#print "$testenv\n";
    if ($testenv =~ m|.*OS\sX|) {
        $header .= "<td style=\"text-align:center;vertical-align:middle\"><img src=\"$imgDir/mac.png\"><br/>";	
        ($testenv =~ m|.*OS\sX\s(\d\d.\d)\s|);
    	$header .= "$1<br/>";	

        $header .= chrome($testenv);
        $header .= firefox($testenv);
		$header .= ie($testenv);
		$header .= opera($testenv);
        $header .= safari($testenv);

    } elsif ($testenv =~ m|.*Linux|) {
        $header .= "<td style=\"text-align:center;vertical-align:middle\"><img src=\"$imgDir/linux.png\"><br/>";	

        $header .= chrome($testenv);
        $header .= firefox($testenv);
		$header .= ie($testenv);
		$header .= opera($testenv);
        $header .= safari($testenv);

    } elsif ($testenv =~ m|.*Windows\s|) {
        $header .= "<td style=\"text-align:center;vertical-align:middle;\"><img src=\"$imgDir/windows.png\"><br/>";
        if ($testenv =~ m|.*Windows\s(\d*)\s.*|) {
            $header .= "$1</br>";	
        } else {
            $header .= "XP</br>";		
        }

        $header .= chrome($testenv);
        $header .= firefox($testenv);
		$header .= ie($testenv);
		$header .= opera($testenv);
        $header .= safari($testenv);

    } else {
        $header .= "<td style=\"text-align: center;\">$testenv";
    }

    $header .= "</td>";	
}
$header .= "</tr>\n";


print "$header\n";
foreach my $test (@tests) {
    my $testsresult = "<td>" . $test;
    for ($i = $testLengthMax - length($test); $i >= 0; $i--) {
        $testsresult .= " ";
    }
    $testsresult .=  "</td>";
    foreach my $testenv (@filelist) {
        my $result = `grep $test $testenv.results`;

        ($testenv =~ m|.*-(.*-.*-.*-.*)?-\d*|s);
        my $dirMatch = $1;
#	    print "\t$dirMatch\n";
#	    `ls -d *SmokeTest*$dirMatch* > $dirMatch.txt`;

        my $testDir = `ls -d $test-$dirMatch*`;
        $testDir = substr($testDir, 0, length($testDir) - 1);
#        print "\t\t$testDir\n";
        if ($result =~ m|^.* passed$|s) {
            $testsresult .= "<td style=\"text-align: center; background-color: 00FF00\"><a href=\"$testDir/$testDir-video.flv\">S</a></td>";
        } elsif ($result =~ m|^.* failed$|s)  {
            $testsresult .= "<td style=\"text-align: center; background-color: FF0000\"><a href=\"$testDir/$testDir-video.flv\">F</a></td>";
        } else {
            $testsresult .= "<td style=\"text-align: center; background-color: FFFF00\">E</td>";
        }
    } 
    print "<tr>$testsresult</tr>\n";
}
print "</table></body></html>"


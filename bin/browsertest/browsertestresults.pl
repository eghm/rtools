#!/usr/local/wu/bin/perl
use Getopt::Long;
use Tie::File;
use Date::Manip
GetOptions( "f=s" => \$importdir); # -f=/path/
opendir(DIR, $importdir);

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


# confluence table header
#my $header = "|| Test / ENV ||";
#foreach my $testenv (@filelist) {
#    if ($testenv =~ m|^\S*?\-(.*)\-\d*.*|s) {
#      $header .= $1 . "||";
#    }
#}

my $header;
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

# aligned along the top
for ($i = 0; $i < $testenvsLengthMax; $i++) {
    $header .= $headerspace;
    foreach my $testenv (@testenvs) {
        if (length($testenv) > $i) {
            $header .= substr($testenv, $i, 1) . " ";
        } else {
            $header .= "  ";
        }
    }
    $header .= "\n";
}


print "$header\n";
foreach my $test (@tests) {
    my $testsresult = "||" . $test;
    for ($i = $testLengthMax - length($test); $i >= 0; $i--) {
        $testsresult .= " ";
    }
    $testsresult .=  "||";
    foreach my $testenv (@filelist) {
        my $result = `grep $test $testenv.results`;
        if ($result =~ m|^.* passed$|s) {
            $testsresult .= "S|";
        } elsif ($result =~ m|^.* failed$|s)  {
            $testsresult .= "F|";
        } else {
            $testsresult .= "-|";
        }
    } 
    print "$testsresult\n";
}


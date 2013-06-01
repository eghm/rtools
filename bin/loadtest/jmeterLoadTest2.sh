# server, test, wiki user, wiki passtoken
cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 1 1 1 $4

$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 2 1 1 $4

$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 3 1 1 $4

$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 5 1 1 $4
  
$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 10 1 1 $4
  
$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 20 1 1 $4
  
$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 40 1 1 $4
  
$R_HOME/rtools/bin/loadtest/jmeterSeq2.sh $1 $2 $3 80 1 1 $4
  
 

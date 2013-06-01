# server, test, wiki user, wiki passtoken
cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 1 1
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4

cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 2 1
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4

cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 3 1
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4

cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 5 10
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 10 10
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 20 20
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 40 40
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
$R_HOME/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 80 60
$R_HOME/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
 

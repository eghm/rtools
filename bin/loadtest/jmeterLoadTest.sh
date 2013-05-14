# server, test, wiki user, wiki passtoken
cp ../$2.jmx .
/r/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 5 60
/r/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
/r/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 10 60
/r/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
/r/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 20 60
/r/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
/r/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 40 60
/r/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
cp ../$2.jmx .
/r/rtools/bin/loadtest/jmeterThreadsRamp.sh $2 80 60
/r/rtools/bin/loadtest/jmeterSeq.sh $1 $2 $3 $4
  
 

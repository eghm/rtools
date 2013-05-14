# $1 server, $2 jmeter test name without the .jmx $3 wiki username $4 wiki passtoken

parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/loadtest/mkDtsTomcatLogDir.sh
scp tomcat@env11.rice.kuali.org:dts.txt .
/java/jmeter-2.8/bin/jmeter.sh -n -t $2.jmx
sleep 120
parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/loadtest/mvTomcatLogs2Dts.sh
cp ../jvm.txt .
/r/rtools/bin/loadtest/client.sh $1 $3 $4



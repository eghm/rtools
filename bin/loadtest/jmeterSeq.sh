# $1 server, $2 jmeter test name without the .jmx $3 wiki username $4 wiki passtoken $5 java agent line to be appended to CATALINA_OPTS
if [ ! -e "$2".jmx ] 
then
	echo "$2.jmx doesn't exist, exiting."
	exit
fi

parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/loadtest/mkDtsTomcatLogDir.sh < $5
scp tomcat@env11.rice.kuali.org:dts.txt .
/java/jmeter-2.8/bin/jmeter.sh -n -t $2.jmx
sleep 120
parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/loadtest/mvTomcatLogs2Dts.sh
/r/rtools/bin/loadtest/client.sh $1 $3 $4



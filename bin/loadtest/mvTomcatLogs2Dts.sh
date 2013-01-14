export DTS=$(cat ~/dts.txt)
export T_LOGS=/usr/local/tomcat/logs
export DTS_LOGS=$T_LOGS/$DTS

mv $T_LOGS/catalina.out $DTS_LOGS/ ; mv $T_LOGS/*.log $DTS_LOGS/ ; mv $T_LOGS/localhost*.txt $DTS_LOGS/ ; mv $T_LOGS/*.hprof $DTS_LOGS/
# start tomcat backup for wget of logs
/usr/local/tomcat/bin/startup.sh
rm ~/dts.txt

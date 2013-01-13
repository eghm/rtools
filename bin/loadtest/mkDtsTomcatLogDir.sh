/usr/local/tomcat/bin/shutdown.sh
export DTS=$(date +%Y-%m-%d/%H-%M)
export T_LOGS=/usr/local/tomcat/logs
export DTS_LOGS=$T_LOGS/$DTS
mkdir -p $DTS_LOGS
sleep 60
cd $T_LOGS ; mkdir -p bak ; mv *.out bak/ ; mv *.log bak/ ; mv *.txt bak/
cd
/usr/local/tomcat/bin/startup.sh
echo "DTS $DTS"
echo "$DTS" > dts.txt


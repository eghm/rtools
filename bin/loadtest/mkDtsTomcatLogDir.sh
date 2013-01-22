$CATALINA_HOME/bin/shutdown.sh
sleep 60
export T_LOGS=$CATALINA_HOME/logs
if [ -e $T_LOGS/catalina.pid ]
then
    echo "$T_LOGS/catalina.pid exists!  Tomcat didn't shutdown cleanly."
    # TODO kill with threaddump
    exit
fi

cd $T_LOGS ; mkdir -p bak ; mv *.out bak/ ; mv *.log bak/ ; mv *.txt bak/
cd
$CATALINA_HOME/bin/startup.sh
sleep 120
export DTS=$(date +%Y-%m-%d/%H-%M)
export DTS_LOGS=$T_LOGS/$DTS
mkdir -p $DTS_LOGS
echo "DTS $DTS"
echo "$DTS" > ~/dts.txt


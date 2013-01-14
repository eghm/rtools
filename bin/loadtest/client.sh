# RUN JMETER and have test and outputs in the directory this is run from
if [ -z "$1" ]
then
    echo "Required parameter, server"
    exit;
fi
if [ -z "$2" ]
then
    echo "Required parameter, user"
    exit;
fi
if [ -z "$3" ]
then
    echo "Required parameter, password"
    exit;
fi

export SERVER="$1"
export USER="$2"
export PASS="$3"
export R_UI="$4"
if [ -z "$4" ]
then
    export R_UI="KRAD"
fi

if [ -z "$R_HOME" ]
then
    echo "Required env var R_HOME not set."
    exit;
fi

export R_RELEASE="2.1.3"
export R_DESC="Kitchen Sink Input Fields"

scp tomcat@$SERVER:dts.txt .
export DTS=$(cat dts.txt)

if [ -z "$DTS" ]
then
    echo "Required variable, DTS"
    exit;
fi


export WIKI_DTS=${$DTS/\// }
echo $WIKI_DTS

exit
wget -r -np -nH --cut-dirs=2 -R index.html http://env11.rice.kuali.org/tomcat/logs/$DTS

mv *.xml $DTS/
mv *.png $DTS/
mv jmeter.log $DTS/
mv jvm.txt $DTS/
mv *.jmx $DTS/

cd $DTS

contextSed.sh $(pwd)

/java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addPage --space "KULRICE" --title "$R_RELEASE $R_DESC $R_UI JMeter Load Test $WIKI_DTS" --parent "Rice $R_RELEASE Load Testing" --file "contents.txt"

find ./ -name '*.*' -exec /java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addAttachment --space "KULRICE" --title "$R_RELEASE $R_DESC $R_UI JMeter Load Test $WIKI_DTS" --file "{}" \;
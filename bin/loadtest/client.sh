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

if [ -z "$R_HOME" ]
then
    echo "Required env var R_HOME not set."
    exit;
fi

export SERVER="$1"
export USER="$2"
export PASS="$3"

# get the release and build from the given server
wget http://$SERVER/portal.do -O portal.html
grep "class=\"build\"" portal.html > version.xml
# version_dirty.txt has a space before and after the build
cut -f 3 -d : version.xml > version_dirty.txt
export DIRTY_VERSION=$(cat version_dirty.txt)
export R_VERSION=${DIRTY_VERSION/ /}
echo $R_VERSION > version.txt
rm version.xml
rm version_dirty.txt
# now get the release from version.txt
cut -f 1 -d - version.txt > release.txt
export R_RELEASE=$(cat release.txt)
echo $R_RELEASE

# dts.txt doesn't exist since the loadtest log mv script (needs to be done before the wget of the logs) deletes it.....
#scp tomcat@$SERVER:dts.txt .
#export DTS=$(cat dts.txt)

if [ -z "$DTS" ]
then
    echo "Required variable, DTS"
    exit;
fi

wget -r -np -nH --cut-dirs=2 -R index.html http://$SERVER/tomcat/logs/$DTS

sipsTiff2Png.sh $(pwd)

mv *.jtl $DTS/
mv *.png $DTS/
mv jmeter.log $DTS/
mv jvm.txt $DTS/
mv dts.txt $DTS/
mv version.txt $DTS/
mv *.jmx $DTS/

cd $DTS

# there should be only one jmx file, we'll use its name as part of the wiki page title
for f in *.jmx;
do
    jmetername=$(basename "$f")
    export JMETER_NAME="${jmetername%.*}"
done

export R_DESC=$JMETER_NAME

contextSed.sh $(pwd)

export WIKI_DTS=${DTS/\// }

/java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addPage --space "KULRICE" --title "$R_VERSION $R_DESC JMeter Load Test $WIKI_DTS" --parent "Rice $R_RELEASE Load Testing" --file "wiki.txt"

find ./ -name '*.*' -exec /java/confluence-cli-3.1.0/confluence.sh -s https://wiki.kuali.org/ -u $USER -p $PASS --action addAttachment --space "KULRICE" --title "$R_VERSION $R_DESC JMeter Load Test $WIKI_DTS" --file "{}" \;
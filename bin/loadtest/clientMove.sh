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
rm release.txt

if [ -e dts.txt ]
then
    export DTS=$(cat dts.txt)
fi

if [ -z "$DTS" ]
then
    echo "Required variable, DTS"
    exit;
fi

mkdir -p $DTS
mv *.jtl $DTS/
mv *.log $DTS/
mv *.txt $DTS/
mv *.html $DTS/
mv *.jmx $DTS/

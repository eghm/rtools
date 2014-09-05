# R_HOME must be set to find $R_HOME/rtools/bin/loadtest/jtls.txt which defines jtl files and the key used to get the timings of just the page under test
if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
    exit
fi

# build number must be passed in
if [ -z $1 ]
then
	echo "Jenkins build number of rice-2.5-test-jmeter-env19-nightly must be passed in"
	exit
fi

# if an archive directory already exists stop
if [ -d archive ]
then
	echo "archive directory already exists, please rename and try again"
    exit
fi

# if an archive zip file already exists stop
if [ -f "archive.zip" ] 
then
	echo "archive zip file already exists, please rename and try again"
    exit
fi

# if there isn't a renamed archive file for the given build number get it
if [ ! -f "rice-2.5-test-jmeter-env19-nightly-$1.zip" ] 
then
    wget -q --no-check-certificate https://ci.kuali.org/view/rice/view/2.5/view/performance/job/rice-2.5-test-jmeter-env19-nightly/$1/artifact/*zip*/archive.zip

    if [ ! -f "archive.zip" ] 
    then
	echo "archive zip file not found something went wrong with wget"
	exit
    fi

    mv archive.zip rice-2.5-test-jmeter-env19-nightly-$1.zip
fi

# if there isn't an unzipped directory make it
if [ ! -d "rice-2.5-test-jmeter-env19-nightly-$1" ] 
then
    unzip -q rice-2.5-test-jmeter-env19-nightly-$1.zip
    mv archive rice-2.5-test-jmeter-env19-nightly-$1
fi

cd rice-2.5-test-jmeter-env19-nightly-$1

rm -rf jtl.headers.txt

echo "Date" >> jtl.headers.txt
echo "Revision" >> jtl.headers.txt

# Setup pages as CSV file
for f in $(cat $R_HOME/rtools/bin/loadtest/jtls.txt) ; do

    JTL_FILE=$(echo $f | cut -d: -f1)   
    JTL_PAGE=$(echo $f | cut -d: -f2)   

    echo $(basename $JTL_FILE) >> jtl.headers.txt

done 

tr '\n' , < jtl.headers.txt > jtl.headers.csv
echo "" >> jtl.headers.csv

# Setup averages as CVS file
rm -rf $1.ave.times

KDATE=$(grep "<br/> Rice KRAD Sample Application Web ::"  logs/login.txt | cut -d: -f 7)
KTIME=$(grep "<br/> Rice KRAD Sample Application Web ::"  logs/login.txt | cut -d: -f 8 | tr -d '\r')
export KDTS="$KDATE:$KTIME"
export RVSION=$(grep SVN-Revision logs/manifest.log | cut -d: -f2 | tr -d ' ' | tr -d '\r')

echo -e "$KDTS" > $1.ave.times
echo -e "$RVSION" >> $1.ave.times

for f in $(cat $R_HOME/rtools/bin/loadtest/jtls.txt) ; do

    JTL_FILE=$(echo $f | cut -d: -f1)   
    JTL_PAGE=$(echo $f | cut -d: -f2)

	rm -rf $(basename $JTL_FILE).times

# CI results are in a different location than if run locally
#echo "grep lb=.$JTL_PAGE rice-framework/krad-sampleapp/web/target/jmeter/results/$(basename $JTL_FILE) | cut -d\" -f2"
    grep lb=.$JTL_PAGE rice-framework/krad-sampleapp/web/target/jmeter/results/$(basename $JTL_FILE) | cut -d\" -f2 >> $(basename $JTL_FILE).times

    awk '{s+=$1}END{print s/NR}' RS=" " $(basename $JTL_FILE).times >> $1.ave.times

done 

tr '\n' , < $1.ave.times > $1.ave.times.csv
echo "" >> $1.ave.times.csv

# Display
echo -e "\n\n\n"
cat jtl.headers.csv
cat $1.ave.times.csv

# Cleanup
rm -rf jtl.headers.txt
rm -rf jtl.headers.csv
rm -rf *.times

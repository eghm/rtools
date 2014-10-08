export XMLGREP=$(which xml_grep)
if [ -z "$XMLGREP" ]
then
  echo "This script uses xml_grep ( see http://search.cpan.org/dist/XML-Twig/tools/xml_grep/xml_grep )"
  exit
fi

xml_grep "//bean[@parent='Uif-Link']" rice-framework/krad-sampleapp/web/src/main/resources/org/kuali/rice/krad/demo/uif/components/KradSampleAppDemo.xml | grep -v 2014 | grep -v "</file>" | grep -v "</xml_grep" > libsLinks.xml

echo "LINK TEXTS"
# Link Text
cut -d \" -f 4 libsLinks.xml > libsLinkTexts.txt

IFS=''
while read data; do
    echo "libs Menu Link Text $data:"
	find rice-framework/krad-sampleapp/web/src/it/java/org/kuali/rice/krad/demo/uif/library -name '*.java' | xargs grep -l "$data"
	echo -e "\n"
done < libsLinkTexts.txt


echo -e "\n\n\n\nLINKS"
# Links
cut -d \" -f 2 libsLinks.xml | cut -d} -f 2 | grep -v Menu | grep -v "1.0"> libsLinks.txt

IFS=''
while read data; do
    echo "libs Links $data:"
	find rice-framework/krad-sampleapp/web/src/it/java/org/kuali/rice/krad/demo/uif/library -name '*.java' | xargs grep -l "$data"
	echo -e "\n"
done < libsLinks.txt

rm libsLinks.xml
rm libsLinkTexts.txt
rm libsLinks.txt

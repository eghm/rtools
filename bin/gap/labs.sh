XMLGREP=$(xml_gre -v)
if [ -z "$XMLGREP" ]
then
  echo "This script uses xml_grep ( see http://search.cpan.org/dist/XML-Twig/tools/xml_grep/xml_grep )"
  exit
fi

xml_grep "//bean[@parent='Uif-Link']" rice-framework/krad-sampleapp/web/src/main/resources/org/kuali/rice/krad/labs/LabsMenu.xml | grep -v 2014 | grep -v "</file>" | grep -v "</xml_grep" > labsLinks.xml

echo "LINK TEXTS"
# Link Text
cut -d \" -f 4 labsLinks.xml > labsLinkTexts.txt

IFS=''
while read data; do
    echo "Labs Menu Link Text $data:"
	find rice-framework/krad-sampleapp/web/src/it/java/org/kuali/rice/krad/labs -name '*.java' | xargs grep -l "$data"
	echo -e "\n"
done < labsLinkTexts.txt


echo -e "\n\n\n\nLINKS"
# Links
cut -d \" -f 2 labsLinks.xml | cut -d} -f 2 | grep -v Menu | grep -v "1.0"> labsLinks.txt

IFS=''
while read data; do
    echo "Labs Links $data:"
	find rice-framework/krad-sampleapp/web/src/it/java/org/kuali/rice/krad/labs -name '*.java' | xargs grep -l "$data"
	echo -e "\n"
done < labsLinks.txt

rm labsLinks.xml
rm labsLinkTexts.txt
rm labsLinks.txt
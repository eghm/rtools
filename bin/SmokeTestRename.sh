# module to run rename on, pattern to find on
# SmokeTestRename.sh rice-framework Demo*SmokeTest.java
find $1 -name "$2" > DemoSmokeTests.txt
cp DemoSmokeTests.txt AftSmokeTests.txt

while read f; do
	mv AftSmokeTests.txt AftSmokeTests.orig
#	echo $f
	export smokeTest=$(basename "$f")
	export smokeTestDir=$(dirname "$f")
	echo "$smokeTest" > SmokeTest.txt

	sed 's|SmokeTest.java|Aft.java|g' SmokeTest.txt > Afts.txt
	sed 's|DemoLabs|Labs|g' Afts.txt > Afts2.txt
	sed 's|DemoLibrary|Demo|g' Afts2.txt  > Afts3.txt
	sed 's|XML|Xml|g' Afts3.txt  > Afts4.txt
	sed 's|MV|Mv|g' Afts4.txt  > Afts5.txt
	sed 's|URL|Url|g' Afts5.txt  > Afts6.txt
	sed 's|STJUnitBkMrkGen|BkMrkAft|g' Afts6.txt  > Afts7.txt
	sed 's|STJUnitNavGen|NavAft|g' Afts7.txt  > Afts8.txt
	sed 's|FYI|Fyi|g' Afts8.txt  > Afts9.txt
	sed 's|KIM|Kim|g' Afts9.txt  > Afts10.txt
	sed 's|UIF|Uif|g' Afts10.txt  > Afts11.txt
	sed 's|WSDL|Wsdl|g' Afts11.txt  > Afts12.txt
	sed 's|EDoc|Edoc|g' Afts12.txt  > Afts13.txt
#	sed 's|STJUnitBase|AftBase|g' Afts13.txt  > Afts14.txt
#	sed 's|Abstract||g' Afts14.txt  > Afts15.txt
#	sed 's|ST|Aft|g' Afts15.txt  > Afts16.txt

	export aft=$(sed 's|.java||g' Afts13.txt)
    export st=$(sed 's|.java||g' SmokeTest.txt)
	rm Aft*.txt
	echo $aft from $st
#	echo "$smokeTest $smokeTestDir $aft"
	sed "s|$st.java|$aft.java|g" AftSmokeTests.orig > AftSmokeTests.txt

	mv $f $f.orig
	sed "s|$st|$aft|g" $f.orig > $f
	rm $f.orig
    svn mv $f $smokeTestDir/$aft.java
	rm AftSmokeTests.orig
done < DemoSmokeTests.txt

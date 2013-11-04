find rice-middleware/sampleapp/src/it/java -name "*Aft.java" > STJUnit.txt

while read f; do
	mv $f $f.orig
	sed "s|STJUnitBase|AftBase|g" $f.orig > $f
	rm $f.orig
done < STJUnit.txt

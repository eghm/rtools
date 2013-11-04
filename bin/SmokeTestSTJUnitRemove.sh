find rice-middleware/sampleapp/src/it/java -name "*STJUnitBase.java" > STJUnit.txt

while read f; do
	svn rm $f
done < STJUnit.txt

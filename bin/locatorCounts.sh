rm -p doubleslashes.count.txt
grep "\"//" rice-middleware/sampleapp/src/it/java/edu/samplu/common/WebDriverLegacyITBase.java > doubleslashes.txt

for f in $(cat doubleslashes.txt) ; do 
	echo "$(grep -c \"$f\" rice-middleware/sampleapp/src/it/java/edu/samplu/common/WebDriverLegacyITBase.java)" >> doubleslashes.count.txt
	cat doubleslashes.count.txt
done

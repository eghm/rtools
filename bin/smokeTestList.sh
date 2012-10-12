find sampleapp/ -name "*LegacyIT.java" > LegacyITs.txt
rev LegacyITs.txt > LegacyITs.rev
cut -d / -f 1 LegacyITs.rev > LegacyITs.cut1.rev
cut -d . -f 2 LegacyITs.cut1.rev > LegacyITs.cut2.rev
rev LegacyITs.cut2.rev > LegacyITs.cut2.txt
for line in $(cat LegacyITs.cut2.txt); do
	wget http://testuserpool.appspot.com//namepool?name=$line
done; 



rm LegacyITsUsers.txt
find sampleapp/ -name "*LegacyIT.java" > LegacyITs.out
rev LegacyITs.out > LegacyITs.rev
cut -d / -f 1 LegacyITs.rev > LegacyITs.cut1.rev
cut -d . -f 2 LegacyITs.cut1.rev > LegacyITs.cut2.rev
rm LegacyITs.out
rm LegacyITs.rev
rm LegacyITs.cut1.rev
rev LegacyITs.cut2.rev > LegacyITs.cut2.txt
rm LegacyITs.cut2.rev
mv LegacyITs.cut2.txt LegacyITs.txt
let "i=0";
for line in $(cat LegacyITs.txt);
do
	echo "$line loadtester$i" >> LegacyITsUsers.txt;
    let "i+=1";
done; 
rm LegacyITs.txt
cat LegacyITsUsers.txt
find sampleapp/ -name "*LegacyIT.java" > LegacyITs.out
rev LegacyITs.out > LegacyITs.rev
cut -d / -f 1 LegacyITs.rev > LegacyITs.cut1.rev
cut -d . -f 2 LegacyITs.cut1.rev > LegacyITs.cut2.rev
rm LegacyITs.out
rm LegacyITs.rev
rm LegacyITs.cut1.rev
rm LegacyITs.cut2.rev
rev LegacyITs.cut2.rev > LegacyITs.cut2.txt
mv LegacyITs.cut2.txt LegacyITs.txt

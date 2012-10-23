echo "updating log4j.properties"
echo "s|/logs/logs.logs|/logs/$1/logs.logs|g" > .rdev/$1-log4j.sed
echo "s|R_HOME|$R_HOME|g" >> .rdev/$1-log4j.sed

sed -f .rdev/$1-log4j.sed ../rtools/etc/log4j.properties  > sampleapp/src/main/resources/log4j.properties
sed -f .rdev/$1-log4j.sed ../rtools/etc/log4j.properties  > standalone/src/main/resources/log4j.properties
sed -f .rdev/$1-log4j.sed ../rtools/etc/log4j.properties  > $1-log4j.properties
cp $1-log4j.properties it/internal-tools/src/main/resources/rice-testharness-default-log4j.properties

mkdir -p core/impl/src/main/java/com/veerasundar/dynamiclogger
cp ../rtools/etc/NewLogFileForEachRunAppender.java core/impl/src/main/java/com/veerasundar/dynamiclogger/

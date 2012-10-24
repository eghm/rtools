echo "updating log4j.properties for new log file per run appender"
echo "s|/logs/logs|/logs/$1/logs|g" > .rdev/$1-log4j.sed
echo "s|R_HOME|$R_HOME|g" >> .rdev/$1-log4j.sed

# the log4j.properties we are going to use for all log4j.properties
sed -f .rdev/$1-log4j.sed ../rtools/etc/log4j.properties  > $1-log4j.properties

# replace existing log4j.properties with the one we just created TODO rm and link?
find ./ -name 'log4j.properties' -exec cp $1-log4j.properties {} \;
# and replace the rice-testharness default log4.properties too
cp $1-log4j.properties it/internal-tools/src/main/resources/rice-testharness-default-log4j.properties

mkdir -p core/impl/src/main/java/com/veerasundar/dynamiclogger
cp ../rtools/etc/NewLogFileForEachRunAppender.java core/impl/src/main/java/com/veerasundar/dynamiclogger/

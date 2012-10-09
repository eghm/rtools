export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

mvn -f sampleapp/pom.xml test-compile > $DTS.$RUNNING_TEST.test-compile.out
mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1  -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$4 -Dremote.driver.saucelabs.version=$5 -Dremote.driver.saucelabs.platform=$6 -Dremote.driver.saucelabs.browser=$7 -Dremote.public.userpool=$8 > $DTS.$RUNNING_TEST.stests.out

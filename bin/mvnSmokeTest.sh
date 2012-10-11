#export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

mvn-named-log.sh $RUNNING_TEST.test-compile.out -f sampleapp/pom.xml test-compile
mvn-named-log.sh $RUNNING_TEST.out -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$4 -Dremote.driver.saucelabs.platform=$5 -Dremote.driver.saucelabs.browser=$6 -Dremote.public.userpool=$7

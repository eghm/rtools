CAS_USER=$1
CAS_PASS=$2
RESULTS_DIR=$3

mkdir -p $RESULTS_DIR

cd rice-tools-test && mvn failsafe:integration-test -Pstests -Dmaven.failsafe.skip=false -Dit.test=JenkinsJsonAllJobsResults -Dcas.username=$1 -Dcas.password=$2 -Djenkins.jobs=$4 -Dremote.driver.dontTearDownOnFailure=y -Djson.output.dir=$RESULTS_DIR


CAS_USER=$1
CAS_PASS=$2
RESULTS_DIR=$3

mkdir -p $RESULTS_DIR

# mvnLinks
export rDir=${PWD##*/}
export M2_REPO=/java/m2/$rDir

cd rice-tools-test && mvn failsafe:integration-test -Pstests -Dmaven.failsafe.skip=false -Dit.test=JenkinsJsonJobsResults -Dcas.username=$1 -Dcas.password=$2 -Djenkins.jobs=$4 -Dremote.driver.dontTearDownOnFailure=y -Djson.output.dir=$RESULTS_DIR -Dmaven.repo.local=$M2_REPO $5 $6 $7 $8 $9


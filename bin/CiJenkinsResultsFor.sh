CAS_USER=$1
CAS_PASS=$2
RESULTS_DIR=$3

mkdir -p $RESULTS_DIR

# mvnLinks
export rDir=${PWD##*/}
# if repository/r/org/kauli is a file, not a directory, then assume we are in mvnLinks mode
if [ -f "/java/m2/r/org/kuali" ]; then
  export M2_REPO=/java/m2/$rDir
  export MVN_M2_REPO=-Dmaven.repo.local=$M2_REPO
fi

cd rice-tools-test && mvn failsafe:integration-test -Pstests -Dmaven.failsafe.skip=false -Dit.test=JenkinsJsonJobsBuildsResults -Dcas.username=$1 -Dcas.password=$2 -Djenkins.jobs=$4 -Dremote.driver.dontTearDownOnFailure=y -Djson.output.dir=$RESULTS_DIR $MVN_M2_REPO $5 $6 $7 $8 $9


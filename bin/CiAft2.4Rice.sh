stime=$(date '+%s')
export DTS=$(date +%Y%m%d%H%M)
export RESULTS_DIR=rice-2.4-smoke-test-$DTS

export AFT_DIR=$(pwd)

# mvnLinks
export rDir=${PWD##*/}
export M2_REPO=/java/m2/$rDir

cd rice-tools-test && mvn failsafe:integration-test -Pstests -Dmaven.failsafe.skip=false -Dit.test=JenkinsLastCompletedBuildNumber -Dcas.username=$1 -Dcas.password=$2 -Djenkins.jobs=rice-2.4-smoke-test -Dremote.driver.dontTearDownOnFailure=y -Dmaven.repo.local=$M2_REPO > ../rice-2.4-smoke-test-last.txt

JOBS=$(grep rice-2.4-smoke-test: rice-2.4-smoke-test-last.txt)

cd ..
mkdir -p $RESULTS_DIR
cd $RESULTS_DIR
export FULL_RESULTS_DIR=$(pwd)
cd ..

CiJenkinsResultsFor.sh $1 $2 $FULL_RESULTS_DIR $JOBS

CiAnalysis.sh $FULL_RESULTS_DIR 

CiAftLocalRice.sh $FULL_RESULTS_DIR $AFT_DIR


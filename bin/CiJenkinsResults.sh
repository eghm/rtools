CAS_USER=$1
CAS_PASS=$2
RESULTS_DIR=$3

mkdir -p $RESULTS_DIR

cd rice-tools-test && mvn failsafe:integration-test -Pstests -Dmaven.failsafe.skip=false -Dit.test=JenkinsJsonJobsResults -Dcas.username=$1 -Dcas.password=$2 -Djenkins.jobs=rice-2.4-integration-test-mysql-freestyle,rice-2.4-smoke-test,rice-2.4-smoke-test-krad,rice-2.4-smoke-test-krad-labs,rice-2.4-smoke-test-krad-library,rice-2.4-smoke-test-krad-library-2,rice-2.4-smoke-test-krad-library-2a,rice-2.4-smoke-test-krad-library-3,rice-2.4-test-functional-saucelabs,rice-2.4-test-functional-saucelabs-krad-all,rice-2.4-test-functional-saucelabs-krad-demo,rice-2.4-test-functional-saucelabs-krad-labs,rice-2.4-test-functional-saucelabs-krad-library,rice-2.4-test-functional-saucelabs-krad-library-2,rice-2.4-test-functional-saucelabs-krad-library-3,rice-2.4-test-integration-bitronix-freestyle,rice-2.4-test-integration-krad-mysql-freestyle,rice-2.4-test-integration-middleware-mysql-freestyle,rice-2.4-test-integration-mysql-daily-email,rice-2.4-test-integration-oracle-freestyle,rice-2.4-test-unit -Dremote.driver.dontTearDownOnFailure=y -Djson.output.dir=$RESULTS_DIR


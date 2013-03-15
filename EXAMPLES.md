DEVELOPMENT:
* checkout and setup 35797
    * rDev.sh 35797 dbrootpass
* checkout and setup 35797 skipping tests
    * rDev.sh 35797 dbrootpass -DskipTests=true
* run integration tests using version specific config.xml
    * mvn-itest.sh 
* run an integration using version specific config.xml
    * mvn-itest.sh -Dit.test=StyleRepositoryServiceImplTest
* delete 35797 and its databases
    * deleteRevisionAndDBs.sh 35797 dbrootpass

LOCAL SMOKE TESTS, single threaded, against Saucelabs
* Install SaucePatch () and compile the sampleapp tests
* create targets.txt you want to run against (See Saucelabs Resources)
    * windows_2012:ie:10
    * etc.
* Create lists of tests to run with users (admin for single threaded running of tests)
    * rSmokeTestsUsersList.sh
* Using the list from the previous command setup a target for each test:user
    * rSmokeTestsTargetList.sh
* Run
    * rSmokeTest.sh env8.rice.kuali.org saucelabs_user saucelabs_key rVersion SmokeTestsTargetsUsers.txt

LOCAL SMOKE TESTS, multi-threaded, against Saucelabs
* Install SaucePatch () and compile the sampleapp tests
* Create loadtest users (see IdentityPersonRoleWDIT) on the app you will be running the smoke tests against.
    * mvn -f sampleapp/pom.xml -Pstests failsafe:integration-test -Dalt.config.location=/r/37569/37569-common-test-config.xml -Dremote.public.url=env7.rice.kuali.org -Dit.test=XMLIngesterNavIT -DXMLIngester.groupId=2008 -DXMLIngester.userIncludeDTSinPrefix=false -DXMLIngester.userCntBegin=0 -DXMLIngester.userCnt=600  -DXMLIngester.userPrefix=loadtester -Dremote.driver.dontTearDown=y
* If needed create loadtester roles once the NPE is fixed :(
    * mvn -f sampleapp/pom.xml -Pstests failsafe:integration-test -Dalt.config.location=/r/37551/37551-common-test-config.xml -Dremote.public.url=env7.rice.kuali.org -Dit.test=IdentityPersonRoleWDIT -Dtest.role.user.cnt=600 -Dtest.role.user.base=loadtester -Dremote.driver.dontTearDown=y 
* Create target list (so used users are not duplicated)
    * TODO
* Create lists of tests to run with loadtest users
    * TODO rSmokeTestsMultiUsersList.sh


MULTISERVER TASKS:

PREREQUISITES
* rtools supporting servers
* http://www.gnu.org/software/parallel/
* create local account ec2-user and save the private key as .ssh/id_rsa
* servers.txt with one ip address per line

SYNC TO SERVERS:
* Update a test file
    * cd $R_HOME; find 35797 -name 'IdentityPersonRoleWDIT.java' | parallel --sshloginfile ~/servers.txt --transfer wc
* Recompile sampleapp tests
    * parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/remoteMvnTestCompile.sh 35962
* mvn clean install
    * parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/remoteMvnCleanInstall.sh 35962 -DskipTests=true

PARALLEL INTEGRATION TESTS:
* create list of integration tests
    * find it -name '*Test.java' | grep -v Abstract | sed 's|/| |g' | awk '{print $NF}' > itestsj.txt ; cut -d . -f 1 itestsj.txt > iTestsAll.txt
* start your databases
    * parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/remoteDbStart.sh
* push - iTestsAll.txt is a file of all the tests, one test per line
    * pushList.sh ~/servers.txt iTestsAll.txt iTests.txt
* verify push
    * parallel --tag --nonall --sshloginfile ~/servers.txt cat iTests.txt
    * parallel --tag --nonall --sshloginfile ~/servers.txt wc -l iTests.txt
* execute
    * parallel --tag --nonall --sshloginfile ~/servers.txt rtools/bin/remoteItest.sh 36141 -DskipTests=true
* retrieve logs
    * remoteLogsFetch.sh 36141
    * find 36141/ -name '*-itest-*.out' -exec grep -L "Failures: 0, Errors: 0, Skipped: 0" {} \;

PARALLEL SMOKE TESTS: assumes a csv file will supply values, note order of sauce params is different from old smoke tests
* create LegacyITsUsers.txt file from within a R_VERSION directory:
    * smokeTestUsersList.sh
* setup saucelabs.csv
   * 10,saucelabs_user,saucelabs_key
* expand the saucelabs.csv by including each line the number of time indicated by the first csv.
   * expand.sh saucelabs.csv
* paste LegacyITsUsers.txt and saucelabs.txt.expanded two files together using:
   * smokeTestList.sh > SauceSmokeTests.csv
* Bring up one instance and run LoginLogoutLegacyTest (sometimes windows instances Java fails, don't run all the tests when that is happening)
   * grep LoginLogout SauceSmokeTests.csv > SauceSmokeTestLoginLogout.csv
   * pushList.sh servers.txt SauceSmokeTestLoginLogout.csv smokeTestList.csv
   * parallel --tag --nonall --sshloginfile servers.txt rtools/bin/remoteSmokeTest.sh 35962 env11.rice.kuali.org ie 8 windows_2003
* Bring up the other servers and push out the tests
   * pushList.sh servers.txt SauceSmokeTests.csv smokeTestList.csv
* execute
   * parallel --tag --nonall --sshloginfile servers.txt rtools/bin/remoteSmokeTest.sh 35962 env11.rice.kuali.org ie 8 windows_2003

OLD PARALLEL SMOKE TESTS: pass everything on command line, but the the test might be overwritten by LegacyITUsers.txt is populated
* create LegacyITsUsers.txt file from within a R_VERSION directory:
    * smokeTestUsersList.sh
* Logged in locally as ec2-user, breakup the tests.txt list and push each server its own chunk. 
   * pushList.sh servers.txt LegacyITsUsers.txt LegacyITsUsers.csv
* Logged in locally as ec2_user, cat the LegacyITsUsers.txt that got pushed to each server
    * parallel --tag --nonall --sshloginfile servers.txt  cat LegacyITsUsers.csv
* Logged in locally as ec2-user, start the servers executing their LegacyITsUsers.txt, in this case, because LegacyITsUsers.txt is present and verified by the commands above, the it.test (LoginLogoutLegacyIT) is ignored as is the user (admin), but required to keep all the param numbers the same NOTE different (poor) order of saucelabs params:
    * parallel --tag --nonall --sshloginfile servers.txt rtools/bin/mvnSmokeTest.sh env11.rice.kuali.org saucelabsuser saucelabskey 12 Windows_2008 opera LoginLogoutLegacyIT admin 35558
* Logged in as ec2-user, transfer a file to the servers
    * find 35797 -name 'IdentityPersonRoleWDIT.java' | parallel --sshloginfile ~/servers.txt --transfer wc


OTHER:

SQLRest:
* (re) installing sqlrest on ENV11 to work with ORACLE and bouncing tomcat, sqlrest gives an error :(
    * rm rGitSqlRest.sh ; rm -rf rtools ; rm -rf .rdev ; wget https://raw.github.com/eghm/rtools/master/bin/rGitSqlRest.sh ; chmod 755 rGitSqlRest.sh ; ./rGitSqlRest.sh ORACLE USER PASS localhost 1521 oracle.jdbc.driver.OracleDriver jdbc:oracle:thin:@oracle.rice.kuali.org:1521:ORACLE ; cat sqlrestconf-ORACLE.xml
    * /usr/local/tomcat/bin/shutdown.sh
    * /usr/local/tomcat/bin/startup.sh
    * tail -f /usr/local/tomcat/logs/catalina.out

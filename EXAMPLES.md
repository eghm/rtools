# DEVELOPMENT:
* checkout and setup 35797
** rDev.sh 35797 dbrootpass
* checkout and setup 35797 skipping tests
** rDev.sh 35797 dbrootpass -DskipTests=true
* run integration tests using version specific config.xml
** mvn-itest.sh 
* run an integration using version specific config.xml
**mvn-itest.sh -Dit.test=StyleRepositoryServiceImplTest
* delete 35797 and its databases
** deleteRevisionAndDBs.sh 35797 dbrootpass

# SMOKE TESTS:
# create the tests.txt file used in the next example, from within a R_VERSION directory, copy the output file LegacyITsUsers.txt from the output of:
smokeTestList.sh
# Logged in locally as ec2-user, breakup the tests.txt list and push each server its own chunk.  tests.txt is a colon delimited file of SimpleTestNameIT:userToRunLoadTestAs:AdditionalParameters 
/r/rtools/bin/smokeTestListPush.sh servers.txt tests.txt
# Logged in locally as ec2_user, cat the LegacyITsUsers.txt that got pushed to each server
parallel --tag --nonall --sshloginfile servers.txt  cat LegacyITsUsers.txt
# Logged in locally as ec2_user, start the servers executing their LegacyITsUsers.txt, in this case, because LegacyITsUsers.txt is present and verified by the commands above, the it.test (LoginLogoutLegacyIT) is ignored as is the user (admin), but required to keep all the param numbers the same:
parallel --tag --nonall --sshloginfile servers.txt rtools/bin/mvnSmokeTest.sh env11.rice.kuali.org saucelabsuser saucelabskey 12 Windows_2008 opera LoginLogoutLegacyIT admin 35558

# SQLRest:
# (re) installing sqlrest on ENV11 to work with ORACLE and bouncing tomcat, sqlrest gives an error :(
rm rGitSqlRest.sh ; rm -rf rtools ; rm -rf .rdev ; wget https://raw.github.com/eghm/rtools/master/bin/rGitSqlRest.sh ; chmod 755 rGitSqlRest.sh ; ./rGitSqlRest.sh ORACLE USER PASS localhost 1521 oracle.jdbc.driver.OracleDriver jdbc:oracle:thin:@oracle.rice.kuali.org:1521:ORACLE ; cat sqlrestconf-ORACLE.xml
/usr/local/tomcat/bin/shutdown.sh
/usr/local/tomcat/bin/startup.sh
tail -f /usr/local/tomcat/logs/catalina.out

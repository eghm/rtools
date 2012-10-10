WARNING		WARNING		WARNING		WARNING
=========================================================
rm -rf is used in these scripts!!  Blind use may be hazardous!!!  Have backups available!!!!

WARNING		WARNING		WARNING		WARNING
=========================================================
Tools developed on OSX for rice with MySQL, I also use these on ec2 unix.  Assuming rtools is in $R_HOME (set as an environmental variable).  I use /r

I don't update.  I only create new revisions, which I create a git repository for.  I do create DBs for each version I setup.
An example workflow would be:
* create a new version of rice trunk in $R_HOME/version#:
** rDev.sh 34866 rootdbpass
* Open the Intellij project $R_HOME/config/idea/intellij
* Save nice piece of work I want to make sure I don't break:
** gitAll.sh
* When I want to update I create a version of rice of that version
** rDev.sh 34892 rootdbpass
* Merge my changes from $R_HOME/34866 to $R_HOME/34892


Directory structure:
    $R_HOME/rtools/bin - scripts
                   rDev.sh - dev env init script. Required parameters: version# and DB root user password.  See script file for options
                   deleteRevisionAndDBs.sh - undo rDev.sh. create git diff patch in $R_HOME. Required parameters: version# and DB root user password.
    $R_HOME/rtools/etc - templates, etc.
    $R_HOME/logs - log directory.  Version logs will be placed in $R_HOME/logs/version#/ and symlinked to $R_HOME/version#/
    $R_HOME/trunk - rice trunk, it is assumed you will _NOT_ be working in this directory
    $R_HOME/version#/ - directories you will be working in.
    $R_HOME/version#/.rdev - directory containing rDev build files create by running the rDev.sh script


LOOK AT THESE, DON'T CHECK THESE CHANGES IN! 
--------------------------------------------
You can see these differences via git, or in SVN if you go look at the differences before doing anything after running rDev.sh.

rDev.sh does a lot.  It patches and updates existing files for behavior that makes development easier.  It makes use of these scripts:
gitAll.sh - script to check everything new and modified into the local git copy with a date time stamp comment.
mysqlCreateDBs.sh - creates three DBs for this version#. version#clean as a reference, version#wip for developing in, and version#test.  Required parameters are version# and DB root user password.
rPatches.sh - patches that help with development
r*Mysql.sh - create configurations for this version# placed in root version# directory
rSpyProperties.sh - p6spy enabled by default if jar is in /java/drivers see https://wiki.kuali.org/display/KULRICE/Break+on+execution+of+a+certain+SQL+query
rLogin.sh - autologin as admin
rNoCacheFilter.sh - configure a servlet filter to set the no cache flag in the http headers
rIntellijConfigh.sh - configure intellij  run configs to use generated configuration files
rDtsLogFiles.sh - setup a log4j append that rotates the log file each run
rKradreload.sh - setup https://wiki.kuali.org/display/KULRICE/Reloading+Data+Dictionary+Setup
mvn-clean-install.sh - run a mvn clean install using the generated configuration files, and  mvn-log.sh to log the results to $R_HOME/logs/version#/ and linked the the version# root.
mvnLinks.sh - disabled by default see mvnLinks.sh comments


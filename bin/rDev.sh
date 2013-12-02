#!/bin/bash
# svn revision, db root password, db username, db password, [rice db username], [rice db password], [saucelabs username, saucelabs access key]
# to checkout a brach set R_SVN=https://svn.kuali.org/repos/rice/branches/rice-2.1
stime=$(date '+%s')
export DTS=$(date +%Y%m%d%H%M)

if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

if [ -z "$R_SVN" ]
then
    export R_SVN=https://svn.kuali.org/repos/rice/trunk
fi

echo -e "\n\nDuring rDev.sh it is normal for there to be a few svn: '.' is not a working copy messages. which are okay to ignore. These are from the various logging scripts which run a svndiff to a log before executing commands.\n"
echo -e "ln: File exists are also typically safe to ignore, logging files already exist and will be appended too\n\n "

export RICE_DB_USER=$3
export RICE_DB_PASS=$4

if [ -z "$RICE_DB_USER" ]
then
    export RICE_DB_USER=RICE
    export RICE_DB_PASS=RICE
fi

#export RICE_PORT=$5
#if [ -z "$RICE_PORT" ]
#then
#    export RICE_PORT=8080
#fi


cd $R_HOME
mkdir -p $R_HOME/logs/$1
mkdir -p $R_HOME/$1

#if [ "$(ls -A $R_HOME/$1)" ]
#then
#     echo "$R_HOME/$1 should be emtpy but is not.  Hangning file pointer possible, exiting."
#     exit
#fi

mkdir -p $R_HOME/$1/.rdev

# we only checkout the db stuff, if there is a problem we avoid checking out everything.
# however, if there was just a release the whole project needs to be checked out.
rMysqlDBs.sh $1 $2 $RICE_DB_USER $RICE_DB_PASS

cd $R_HOME/$1

if [ ! -e db ]
then
    echo "db and script/ddl directories should exist was svn skipped or have an error?"
	exit
fi

if [ ! -e config ]
then
    echo -e "\nsvn checkout of the rest of $1 this will take a while..."
    # this could probably be done better the db and scripts dirs are already present from the rMysqlDBs.sh 
	rm -rf db
	rm -rf scripts
    log-command.sh rdev.svn.co svn --trust-server-cert --non-interactive checkout -r $1 $R_SVN/ .
    # what is up with these updates??? why are these directories missing?
    if [ ! -e rice-framework ]
    then
        log-command.sh rdev.svn.up.krms svn --trust-server-cert --non-interactive update rice-framework -r $1
    fi
    if [ ! -e rice-middleware ]
    then
        log-command.sh rdev.svn.up.it svn --trust-server-cert --non-interactive update rice-middleware -r $1
    fi
    if [ ! -e scripts ]
    then
        log-command.sh rdev.svn.up.client-contrib svn --trust-server-cert --non-interactive update scripts -r $1
    fi
fi

if [ ! -e config ]
then
    echo "config directory should exist was svn skipped or have an error?"
	exit
fi

echo "running custom updates"

# for installing the saucelabs quickstart, see saucelabs patch in rPatches.sh
# Sauce Labs params are a problem if rice db user and pass are not given
#if [ ! -z "$7" ]
#then
#    rSauceLabs.sh $6 $7
#fi

# get rid of the file not found exceptions
#touch core/impl/OJB.properties
#echo "<descriptor-repository version=\"1.0\"></descriptor-repository>" > core/impl/repository.xml
#touch kns/OJB.properties
#touch impl/OJB.properties
#echo "<descriptor-repository version=\"1.0\"></descriptor-repository>" > impl/repository.xml

# dev tweeks
rPatches.sh
echo -e "\nCreating MySQL config files"
rCommonTestConfigMysql.sh $1 $RICE_DB_USER $RICE_DB_PASS
rAppConfigSampleMysql.sh $1 $RICE_DB_USER $RICE_DB_PASS 8080
rAppConfigKradSampleMysql.sh $1 $RICE_DB_USER $RICE_DB_PASS 8080
rAppConfigStandaloneMysql.sh $1 $RICE_DB_USER $RICE_DB_PASS
rSpyProperties.sh $1
rLogin.sh
rNoCacheFilter.sh
rIntellijConfig.sh $1

if [ -z "$NO_DTS_LOGS" ]
then
	rDtsLogFiles.sh $1
fi

rKradreload.sh

echo -e "\nCreating intellijJunitAltConfigLocation.sh to be used after starting IntelliJ to set JUnit default to use -Dalt.config.location=$R_HOME/$1/$1-common-test-config.xml"
echo "xml ed -u \"/project/component/configuration[@type='JUnit']/option[@name='VM_PARAMETERS']/@value\" -v \"-Dalt.config.location=$R_HOME$/$1/$1-common-test-config.xml\" config/ide/intellij/.idea/workspace.xml" > intellijJunitAltConfigLocation.sh

echo ""
log-command.sh rdev.git.add git add -A 
echo "git applied rDev custom updates commit"
log-command.sh rdev.svn.commit git commit -a -m "applied rDev custom updates"

echo -e "\nStarting mvn-clean-install.sh this will take a while..."
mvn-clean-install.sh $5 $6 $7 $8 $9 -T 4

#mvnLinks.sh $1
mkdir -p $R_HOME/logs/$1/rDev-$DTS
mv $R_HOME/logs/$1/*.out $R_HOME/logs/$1/rDev-$DTS/
mv $R_HOME/logs/$1/*.log $R_HOME/logs/$1/rDev-$DTS/
echo -e "Logs are available in $R_HOME/logs/$1/rDev-$DTS/"
etime=$(date '+%s')
dt=$((etime - stime))
ds=$((dt % 60))
dm=$(((dt / 60) % 60))
dh=$((dt / 3600))
printf 'Elapsed time %d:%02d:%02d' $dh $dm $ds
echo -e "\n\n"

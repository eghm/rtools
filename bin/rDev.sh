#!/bin/bash
# svn revision, db username, db password, [rice db username], [rice db password], [saucelabs username, saucelabs access key]

stime=$(date '+%s')

if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

export RICE_DB_USER=$3
export RICE_DB_PASS=$4

if [ -z "$RICE_DB_USER" ]
then
    export RICE_DB_USER=RICE
    export RICE_DB_PASS=RICE
fi

cd $R_HOME
mkdir -p $R_HOME/logs/$1
mkdir -p $R_HOME/$1/.rdev

# we only checkout the db stuff, if there is a problem we avoid checking out everything.
rMysqlDBs.sh $1 $2 $RICE_DB_USER $RICE_DB_PASS

cd $R_HOME/$1

if [ ! -e db ]
then
    echo "db and script/ddl directories should exist was svn skipped or have an error?"
	exit
fi

if [ ! -e core ]
then
    echo "svn checkout of the rest of $1 this will take a while..."
    # this could probably be done better the db and scripts dirs are already present from the rMysqlDBs.sh 
	rm -rf db
	rm -rf scripts
    svn checkout -r $1 https://svn.kuali.org/repos/rice/trunk/ . >> svn.out 2>&1
    # what is up with these updates??? why are these directories missing?
    if [ ! -e krms ]
    then
        svn update krms -r $1 >> svn.out 2>&1
    fi
    if [ ! -e it ]
    then
        svn update it -r $1 >> svn.out 2>&1
    fi
    if [ ! -e client-contrib ]
    then
        svn update client-contrib -r $1 >> svn.out 2>&1
    fi
fi

if [ ! -e core ]
then
    echo "core directory should exist was svn skipped or have an error?"
	exit
fi

# Sauce Labs params are a problem if rice db user and pass are not given
echo "running custom updates"
if [ ! -z "$7" ]
then
    rSauceLabs.sh $6 $7
fi

# get rid of the file not found exceptions
touch core/impl/OJB.properties
echo "<descriptor-repository version=\"1.0\"></descriptor-repository>" > core/impl/repository.xml
touch kns/OJB.properties
touch impl/OJB.properties
echo "<descriptor-repository version=\"1.0\"></descriptor-repository>" > impl/repository.xml

# dev tweeks
rPatches.sh
rCommonTestConfigMysql.sh $1 $RICE_DB_USER $RICE_DB_PASS
rAppConfigSampleMysql.sh $1 $RICE_DB_USER $RICE_DB_PASS
rAppConfigStandaloneMysql.sh $1 $RICE_DB_USER $RICE_DB_PASS
rSpyProperties.sh $1
rLogin.sh
rNoCacheFilter.sh
rIntellijConfig.sh $1
rDtsLogFiles.sh $1
rKradreload.sh

git add -A >> git.out 2>&1 
echo "git applied rDev custom updates commit"
git commit -a -m "applied rDev custom updates" >> git.out 2>&1

echo "starting mvn-clean-install.sh"
mvn-clean-install.sh

#mvnLinks.sh $1

etime=$(date '+%s')
dt=$((etime - stime))
ds=$((dt % 60))
dm=$(((dt / 60) % 60))
dh=$((dt / 3600))
printf 'rDev $1 elapsed time %d:%02d:%02d' $dh $dm $ds
#!/bin/bash
# svn revision, db username, db password, [rice db username], [rice db password], [saucelabs username, saucelabs access key]
if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
fi

if [ -z "$3" ]
then
    export 3=RICE
    export 4=RICE
fi

cd $R_HOME
mkdir -p $R_HOME/logs/$1
mkdir -p $R_HOME/$1/.rdev

rMysqlDBs.sh $1 $2 $3 $4

cd $R_HOME/$1

if [ ! -e db ]
then
    echo "db and script/ddl directories should exist was svn skipped or have an error?"
	exit
fi

if [ ! -e core ]
then
	rm -rf db
	rm -rf scripts
    svn checkout -r $1 https://svn.kuali.org/repos/rice/trunk/ .
    # what is up with these updates??? why are these directories missing?
    if [ ! -e krms ]
    then
        svn update krms -r $1
    fi
    if [ ! -e it ]
    then
        svn update it -r $1
    fi
    if [ ! -e client-contrib ]
    then
        svn update client-contrib -r $1
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
rCommonTestConfigMysql.sh $1 $3 $4
rAppConfigSampleMysql.sh $1 $3 $4
rAppConfigStandaloneMysql.sh $1 $3 $4
rSpyProperties.sh $1
rLogin.sh
rNoCacheFilter.sh
rIntellijConfig.sh $1
rDtsLogFiles.sh $1
rKradreload.sh

git add -A
git commit -a -m "applied rDev custom updates"

echo "starting mvn-clean-install.sh"
mvn-clean-install.sh

mvnLinks.sh $1



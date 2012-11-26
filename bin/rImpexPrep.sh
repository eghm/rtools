if [ -z "$R_HOME" ]
then
    echo "env R_HOME is not set!  Exiting."
    exit
fi

if [ -z "$1" ]
then
    echo "first argument must be revision number"
    exit
fi

if [ ! -e $RHOME/$1/.rdev ]
then
    echo "creating directory $R_HOME/$1/.rdev"
    mkdir -p $R_HOME/$1/.rdev
fi

cd $R_HOME/$1

if [ ! -e .rdev ]
then
    echo "$RHOME/$1/.rdev should exist.  Permissions?"
	exit
fi

if [ ! -e db ]
then
    echo "svn checkout of db and scripts directories need for impex to $R_HOME/$1"
	log-command.sh rdev.svn.co.db svn --trust-server-cert --non-interactive checkout -r $1 https://svn.kuali.org/repos/rice/trunk/db $R_HOME/$1/db
	log-command.sh rdev.svn.co.scripts svn --trust-server-cert --non-interactive checkout -r $1 https://svn.kuali.org/repos/rice/trunk/scripts/ddl $R_HOME/$1/scripts/ddl
fi

# rice .gitignore + config/ide .svn/ .settings/ .DS_Store
if [ ! -e .gitignore ]
then
    echo "creating git repository"
    cp ../rtools/etc/gitignore .gitignore
    log-command.sh rdev.git.init git init -q
fi
log-command.sh rdev.git.add git add -A
echo "git pre impex commit"
log-command.sh rdev.git.commit git commit -a -m "pre impex"

# TODO impex-no-user-percent shouldn't be run the very first time after running once and getting a user created failure use mysql as root and execute:
# use mysql;
# grant all privileges on *.* to 'rice'@'localhost' identified by 'rice' with grant option;
# flush privileges
#
# remove the % identified bys causing me problems
echo "impex patching - removing % identified bys"
log-command.sh rdev.impex.patch patch -p1 <../rtools/etc/impex-no-user-percent.patch

loadTestImpex.sh

log-command.sh rdev.git.add git add -A
echo "git applied pre impex patches commit"
log-command.sh rdev.git.commit git commit -a -m "applied pre impex patches"

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

if [ ! -e db ]
then
	svn checkout -r $1 https://svn.kuali.org/repos/rice/trunk/db $R_HOME/$1/db
	svn checkout -r $1 https://svn.kuali.org/repos/rice/trunk/scripts/ddl $R_HOME/$1/scripts/ddl	
fi

# rice .gitignore + config/ide .svn/ .settings/ .DS_Store
if [ ! -e .gitignore ]
then
    echo "creating git repository"
    cp ../rtools/etc/gitignore .gitignore
    git init -q
fi
git add -A
git commit -a -m "pre impex"

# remove the % identified bys causing me problems
patch -p1 <../rtools/etc/impex-no-user-percent.patch 

git add -A
git commit -a -m "applyed impex-no-user-precent.patch"


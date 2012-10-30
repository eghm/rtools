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
    echo "svn checkout of db and scripts directories need for impex to $R_HOME/$1"
	svn checkout -r $1 https://svn.kuali.org/repos/rice/trunk/db $R_HOME/$1/db >> svn.out 2>&1
	svn checkout -r $1 https://svn.kuali.org/repos/rice/trunk/scripts/ddl $R_HOME/$1/scripts/ddl	 >> svn.out 2>&1
fi

# rice .gitignore + config/ide .svn/ .settings/ .DS_Store
if [ ! -e .gitignore ]
then
    echo "creating git repository"
    cp ../rtools/etc/gitignore .gitignore
    git init -q >> git.out 2>&1
fi
git add -A >> git.out 2>&1
echo "git pre impex commit"
git commit -a -m "pre impex" >> git.out 2>&1

# remove the % identified bys causing me problems
echo "removing % identified bys"
patch -p1 <../rtools/etc/impex-no-user-percent.patch

git add -A >> git.out 2>&1
echo "git applyed impex-no-user-precent.patch commit"
git commit -a -m "applyed impex-no-user-precent.patch" >> git.out 2>&1

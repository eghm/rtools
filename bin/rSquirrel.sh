export GROOVY=$(groovy --version)
if [ -z "$GROOVY" ]
then
  echo "groovy not installed will not create SQuirreLSQL aliases.";
  exit
fi

export rDir=${PWD##*/}
if [ "$rDir" = "$R_HOME" ]
then
	echo "Usage: run from a directory created using rDev.sh"
	exit
fi

if [ ! -e ~/.squirrel-sql ]
then
    echo "SQuirreLSQL ~/.squirrel-sql not found, skipping adding of SQuirreLSQL aliases"
    exit
fi
cd $R_HOME/$1
groovy $R_HOME/rtools/bin/uidToString.groovy > .rdev/$1-$2-uid.txt
export DBUID=$(cat .rdev/$1-$2-uid.txt)
export DBNAME=$1$2
export DBUSER=$4
export DBPASS=$4
export DBSERVER=$5
if [ -z "$5" ]
then
	export DBSERVER=localhost
fi
export DBPORT=$6
if [ -z "$6" ]
then
	export DBPORT=3306
fi

if [ ! -e ~/.squirrel-sql/SQLAliases23.xml.bak ]
then
	cp ~/.squirrel-sql/SQLAliases23.xml ~/.squirrel-sql/SQLAliases23.xml.bak
fi
if [ ! -e ~/.squirrel-sql/SQLAliases23_treeStructure.xml.bak ]
then
	cp ~/.squirrel-sql/SQLAliases23_treeStructure.xml ~/.squirrel-sql/SQLAliases23.xml_treeStructure.bak
fi
echo -e "\nCreating SQuirreLSQL aliases for $1$2"
echo "creating .rdev/$1-squirrel-$2.sed with UID of $DBUID"
echo "s|DBUID|$DBUID|g" > .rdev/$1-squirrel-$2.sed
echo "s|DBNAME|$DBNAME|g" >> .rdev/$1-squirrel-$2.sed
echo "s|DBUSER|$DBUSER|g" >> .rdev/$1-squirrel-$2.sed
echo "s|DBPASS|$DBPASS|g" >> .rdev/$1-squirrel-$2.sed
echo "s|DBSERVER|$DBSERVER|g" >> .rdev/$1-squirrel-$2.sed
echo "s|DBPORT|$DBPORT|g" >> .rdev/$1-squirrel-$2.sed
echo "sed -f.rdev/$1-squirrel-$2.sed $R_HOME/rtools/etc/SQuirreLAliases.xml > .rdev/$1-SQuirreLAliases-$2.xml"
sed -f .rdev/$1-squirrel-$2.sed $R_HOME/rtools/etc/SQuirreLAliases.xml > .rdev/$1-SQuirreLAliases-$2.xml
cp ~/.squirrel-sql/SQLAliases23.xml ~/.squirrel-sql/SQLAliases23.xml.orig
sed '$d' ~/.squirrel-sql/SQLAliases23.xml.orig > ~/.squirrel-sql/SQLAliases23.xml
rm ~/.squirrel-sql/SQLAliases23.xml.orig
cat .rdev/$1-SQuirreLAliases-$2.xml >> ~/.squirrel-sql/SQLAliases23.xml
echo "</Beans>" >> ~/.squirrel-sql/SQLAliases23.xml

echo "creating .rdev/$1-squirrel-$2-tree.sed with UID of $DBUID"
echo "s|DBUID|$DBUID|g" > .rdev/$1-squirrel-$2-tree.sed
echo "sed -f .rdev/$1-squirrel-$2-tree.sed $R_HOME/rtools/etc/SQuirreLAliases_treeStructure.xml > .rdev/$1-SQuirreLAliases-$2_treeStructure.xml"
sed -f .rdev/$1-squirrel-$2-tree.sed $R_HOME/rtools/etc/SQuirreLAliases_treeStructure.xml > .rdev/$1-SQuirreLAliases-$2_treeStructure.xml
cp ~/.squirrel-sql/SQLAliases23_treeStructure.xml ~/.squirrel-sql/SQLAliases23_treeStructure.xml.orig
# OMG help
sed '$d' ~/.squirrel-sql/SQLAliases23_treeStructure.xml.orig > ~/.squirrel-sql/SQLAliases23_treeStructure.xml.tmp
sed '$d' ~/.squirrel-sql/SQLAliases23_treeStructure.xml.tmp > ~/.squirrel-sql/SQLAliases23_treeStructure.xml.tmp2
sed '$d' ~/.squirrel-sql/SQLAliases23_treeStructure.xml.tmp2 > ~/.squirrel-sql/SQLAliases23_treeStructure.xml.tmp3
sed '$d' ~/.squirrel-sql/SQLAliases23_treeStructure.xml.tmp3 > ~/.squirrel-sql/SQLAliases23_treeStructure.xml
rm ~/.squirrel-sql/SQLAliases23_treeStructure.xml.tmp*
rm ~/.squirrel-sql/SQLAliases23_treeStructure.xml.orig
cat .rdev/$1-SQuirreLAliases-$2_treeStructure.xml >> ~/.squirrel-sql/SQLAliases23_treeStructure.xml
echo "        </kids>" >> ~/.squirrel-sql/SQLAliases23_treeStructure.xml
echo "        <selected>false</selected>" >> ~/.squirrel-sql/SQLAliases23_treeStructure.xml
echo "    </Bean>" >> ~/.squirrel-sql/SQLAliases23_treeStructure.xml
echo "</Beans>" >> ~/.squirrel-sql/SQLAliases23_treeStructure.xml

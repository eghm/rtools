# user, password, db
cd $R_HOME/rtools/etc
echo -e "\nLoad testers should first be created through the XMLIngesterLegacyIT\n"
rKrimEntityDump2Impex.sh $1 $2 $3
# TODO fix dates
rKrimPrncDump2Impex.sh $1 $2 $3
rLoadTesterRolesImpex.sh $3
loadTesterImpexMerge.sh $3 $4
rm $R_HOME/rtools/etc/KRIM*.$3.impex.xml
#mv $R_HOME/rtools/etc/KRIM*.xml .


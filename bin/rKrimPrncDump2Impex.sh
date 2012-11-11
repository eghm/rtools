# user, password, db
mysqldump --xml -u $1 -p$2 $3 KRIM_PRNCPL_T > KRIM_PRNCPL_T.mysql.$3.xml
xml tr $R_HOME/rtools/etc/mysql.xslt KRIM_PRNCPL_T.mysql.$3.xml > KRIM_PRNCPL_T.mysql.$3.tr.xml
xml tr $R_HOME/rtools/etc/mysqlKrimPrncpl.xslt KRIM_PRNCPL_T.mysql.$3.tr.xml > KRIM_PRNCPL_T.$3.impex.xml
rm KRIM_PRNCPL_T.mysql.$3.tr.xml
rm KRIM_PRNCPL_T.mysql.$3.xml

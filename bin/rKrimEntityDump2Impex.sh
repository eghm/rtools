# user, password, db
mysqldump --xml -u $1 -p$2 $3 KRIM_ENTITY_T > KRIM_ENTITY_T.mysql.$3.xml
xml tr $R_HOME/rtools/etc/mysql.xslt KRIM_ENTITY_T.mysql.$3.xml > KRIM_ENTITY_T.mysql.$3.tr.xml
xml tr $R_HOME/rtools/etc/mysqlKrimEntity.xslt KRIM_ENTITY_T.mysql.$3.tr.xml > KRIM_ENTITY_T.$3.impex.xml
rm KRIM_ENTITY_T.mysql.$3.tr.xml
rm KRIM_ENTITY_T.mysql.$3.xml

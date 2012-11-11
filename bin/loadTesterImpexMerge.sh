cd $R_HOME/rtools/etc
# PRNCPL and ENTITY come from a db dump, so doesn't need to be merged.
#xml tr $R_HOME/rtools/etc/merge.xslt -s with=$R_HOME/rtools/etc/KRIM_PRNCPL_T.$1.impex.xml $2/KRIM_PRNCPL_T.xml > KRIM_PRNCPL_T.xml
#xml tr $R_HOME/rtools/etc/merge.xslt -s with=$R_HOME/rtools/etc/KRIM_ENTITY_T.$1.impex.xml $2/KRIM_ENTITY_T.xml > KRIM_ENTITY_T.xml
xml tr $R_HOME/rtools/etc/merge.xslt -s with=$R_HOME/rtools/etc/KRIM_ROLE_MBR_T.$1.impex.xml $2/KRIM_ROLE_MBR_T.xml > KRIM_ROLE_MBR_T.xml




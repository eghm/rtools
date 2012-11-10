#!/bin/bash
rm loadtesterids.txt
seq -w 0 151 |  parallel echo lt{#} >> loadtesterids.txt
let "i = 1300"
for f in $(cat loadtesterids.txt) ; do
    let "i += 1"
    # 63 is admin
    echo "insert into krim_role_mbr_t (ROLE_MBR_ID, OBJ_ID, ROLE_ID, MBR_ID, MBR_TYP_CD, VER_NBR) values ('T$i', 'T$i', '63', '$f', 'P', 1);" >> loadtesterroles.sql
    let "i += 1"
    # 98 is krms admin
    echo "insert into krim_role_mbr_t (ROLE_MBR_ID, OBJ_ID, ROLE_ID, MBR_ID, MBR_TYP_CD, VER_NBR) values ('T$i', 'T$i', '98', '$f', 'P', 1);" >> loadtesterroles.sql
done

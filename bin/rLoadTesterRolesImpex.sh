#!/bin/bash
rm -f loadtesterids.$1.txt
seq -w 0 151 |  parallel echo lt{#} >> loadtesterids.$1.txt
let "i = 1300"
echo "<!DOCTYPE dataset SYSTEM \"data.dtd\">" > KRIM_ROLE_MBR_T.$1.impex.xml
echo "<dataset>" >> KRIM_ROLE_MBR_T.$1.impex.xml
for f in $(cat loadtesterids.$1.txt) ; do
    let "i += 1"
    # 63 is admin
    echo -e "    <KRIM_ROLE_MBR_T LAST_UPDT_DT=\"20090821035251\" MBR_ID=\"$f\"\n        MBR_TYP_CD=\"P\" OBJ_ID=\"T$i\"\n        ROLE_ID=\"63\" ROLE_MBR_ID=\"T$i\" VER_NBR=\"1\"/>" >> KRIM_ROLE_MBR_T.$1.impex.xml
    let "i += 1"
    # 98 is krms admin
    echo -e "    <KRIM_ROLE_MBR_T LAST_UPDT_DT=\"20090821035251\" MBR_ID=\"$f\"\n        MBR_TYP_CD=\"P\" OBJ_ID=\"T$i\"\n        ROLE_ID=\"63\" ROLE_MBR_ID=\"T$i\" VER_NBR=\"1\"/>" >> KRIM_ROLE_MBR_T.$1.impex.xml
done
echo "</dataset>" >> KRIM_ROLE_MBR_T.$1.impex.xml
rm -f loadtesterids.$1.txt

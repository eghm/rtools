unzip cu-xml-customization.zip

echo "s|package edu.cornell.cynergy.kim|package org.kuali.rice.kim.impl|g" > cynergy.sed
echo "s|package edu.cornell.cynergy.core|package org.kuali.rice.core.impl|g" >> cynergy.sed
echo "s|import edu.cornell.cynergy.kim|import org.kuali.rice.kim.impl|g" >> cynergy.sed
echo "s|import static edu.cornell.cynergy.kim|import static org.kuali.rice.kim.impl|g" >> cynergy.sed

echo "s|import edu.cornell.cynergy.core|import org.kuali.rice.core.impl|g" >> cynergy.sed
echo "s|import static edu.cornell.cynergy.core|import static org.kuali.rice.core.impl|g" >> cynergy.sed



find cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/core | xargs grep -l edu.cornell.cynergy > cynergy.core.txt
for f in $(cat cynergy.core.txt) ; do 
    sed -f cynergy.sed $f > $f.sed
    mv $f.sed $f
done

find cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/kim | xargs grep -l edu.cornell.cynergy > cynergy.kim.txt
for f in $(cat cynergy.kim.txt) ; do 
    sed -f cynergy.sed $f > $f.sed
    mv $f.sed $f
done

mkdir -p core/impl/src/main/java/org/kuali/rice/core/impl/
mv cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/core/xml core/impl/src/main/java/org/kuali/rice/core/impl/

mkdir -p  kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/data/
mv cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/kim/data/xml kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/data/

mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/permission/
mv cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/kim/permission/xml kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/permission/

mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/role/
mv cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/kim/role/xml kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/role/

mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/user
mv cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/kim/user/xml kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/user

mkdir -p kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/
mv cu-xml-customization/impl/src/main/java/edu/cornell/cynergy/kim/xml kim/kim-impl/src/main/java/org/kuali/rice/kim/impl/

rm cynergy.sed
rm cynergy.*.txt

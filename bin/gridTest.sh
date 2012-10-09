updateRunningTest.sh
export RUNNING_TEST=$(cat RUNNING_TEST)
while [ "$RUNNING_TEST" != "null" ]; do
    cp sampleapp/pom.xml sampleapp/pom.xml.orig
    sed 's|<maven.failsafe.includes>**/*IT.java</maven.failsafe.includes>|s|<maven.failsafe.includes>**/$RUNNING_TEST.java</maven.failsafe.includes>|g' sampleapp/pom.xml.orig > sampleapp/pom.xml
    mvnSmokeTests.sh $1 $2 $3 $4 $5 $6 $7
    mv sampleapp/pom.xml.orig sampleapp/pom.xml
    updateRunningTest.sh
    export RUNNING_TEST=$(cat RUNNING_TEST)
done

if [ "$RUNNING_TEST" = "null" ]
then
    echo "No rests left to run."
fi


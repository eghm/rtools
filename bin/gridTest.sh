cd ~/rtools/
git pull
cd
rDev.sh 35224 12345678 rice rice
cd ~/35224
updateRunningTest.sh
export RUNNING_TEST=$(cat RUNNING_TEST)
while [ "$RUNNING_TEST" != "null" ]; do
# TODO use -Dit.test
    cp sampleapp/pom.xml sampleapp/pom.xml.orig
    echo "s|<maven.failsafe.includes>\*\*/\*IT.java</maven.failsafe.includes>|<maven.failsafe.includes>\*\*/$RUNNING_TEST.java</maven.failsafe.includes>|g" > namepooltest.sed
    sed -f namepooltest.sed sampleapp/pom.xml.orig > sampleapp/pom.xml
    mvnSmokeTest.sh $1 $2 $3 $4 $5 $6 $7 
    mv sampleapp/pom.xml.orig sampleapp/pom.xml
    updateRunningTest.sh
    export RUNNING_TEST=$(cat RUNNING_TEST)
done

if [ "$RUNNING_TEST" = "null" ]
then
    echo "No rests left to run."
fi


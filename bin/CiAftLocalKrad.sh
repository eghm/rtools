# JenkinsResults directory, directory to run tests from, [krad, rice]
cd $2

# mvnLinks
export rDir=${PWD##*/}
# if repository/r/org/kauli is a file, not a directory, then assume we are in mvnLinks mode
if [ -f "/java/m2/r/org/kuali" ]; then
  export M2_REPO=/java/m2/$rDir
  export MVN_M2_REPO=-Dmaven.repo.local=$M2_REPO
fi

find $1/JiraGroups -name '*.jira' > Afts2Run.txt

for f in $(cat Afts2Run.txt) ; do 
    echo $f | rev > Aft2Run.rev
    AFT_REV=$(cut -f 1 -d - Aft2Run.rev)
    echo $AFT_REV | rev > Aft.jira
    AFT=$(cut -f 1-2 -d . Aft.jira)
    AFT=$(echo $AFT | tr "." "#")
    rm Aft2Run.rev
    rm Aft.jira

    TEST_DIR=$(dirname $f)

    AFT_ENV=localhost:8080/krad-dev
    echo -e "\nmvn failsafe:integration-test -Pstests -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dremote.public.url=$AFT_ENV -Dit.test=$AFT -Dremote.driver.failure.screenshot=true -Dremote.driver.screenshot.dir=$TEST_DIR -Dremote.jgrowl.enabled=true $MVN_M2_REPO > $f.local.out"
    mvn failsafe:integration-test -Pstests -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dremote.public.url=$AFT_ENV -Dit.test=$AFT -Dremote.driver.failure.screenshot=true -Dremote.driver.screenshot.dir=$TEST_DIR -Dremote.jgrowl.enabled=true $MVN_M2_REPO > $f.local.out

done



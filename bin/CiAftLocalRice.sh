# JenkinsResults directory, directory to run tests from, [krad, rice]
cd $2

find $1/JiraGroups -name '*.jira' > Afts2Run.txt

for f in $(cat Afts2Run.txt) ; do 
    echo $f | rev > Aft2Run.rev
    AFT_REV=$(cut -f 1 -d - Aft2Run.rev)
    echo $AFT_REV | rev > Aft.jira
    AFT=$(cut -f 1-2 -d . Aft.jira)
    AFT=$(echo $AFT | tr "." "#")
    rm Aft2Run.rev
    rm Aft.jira

    AFT_ENV=localhost:8080/kr-dev

    echo -e "\nmvn failsafe:integration-test -Pstests -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dremote.public.url=$AFT_ENV -Dit.test=$AFT"
    mvn failsafe:integration-test -Pstests -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dremote.public.url=$AFT_ENV -Dit.test=$AFT -Dremote.driver.failure.screenshot=true -Dremote.driver.screenshot.dir=$1 > $f.local.out

done


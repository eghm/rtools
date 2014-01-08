# JenkinsResults directory, remote.public.url, it.test
find $1/JiraGroups -name '*.jira' > Afts2Run.txt

for f in $(cat Afts2Run.txt) ; do 
    echo $f | rev > Aft2Run.rev
    AFT_REV=$(cut -f 1 -d Aft2Run.rev)
    AFT=$(echo $AFT_REV | rev)
    echo $AFT
    rm Aft2Run.rev
done


echo "mvn failsafe:integration-test -Pstests -Dremote.jgrowl.enabled=false -Dremote.driver.highlight=false -Dremote.public.url=$2 -Dit.test=$3"

export M2_HOME=~/apache-maven-3.0.4/
export PATH=$PATH:$M2_HOME/bin:~/rtools/bin
cd $1
mvn test-compile -f sampleapp/pom.xml

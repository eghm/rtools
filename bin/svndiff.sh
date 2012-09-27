touch $R_HOME/logs/$rDir/svndiff.$DTS.out 
ln -s $R_HOME/logs/$rDir/svndiff.$DTS.out svndiff.$DTS.out 
svn diff > svndiff.$DTS.out

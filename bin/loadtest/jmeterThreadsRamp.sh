xml ed -u "//stringProp[@name='ThreadGroup.num_threads']" -v $2 $1.jmx > $1$2in.jmx
xml ed -u "//stringProp[@name='ThreadGroup.ramp_time']" -v $3 $1$2in.jmx > $1$2in$3.jmx
rm $1$2in.jmx

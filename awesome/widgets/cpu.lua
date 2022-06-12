
source : https://stackoverflow.com/questions/26791240/how-to-get-percentage-of-processor-use-with-bash

awk -v a="$(awk '/cpu /{print $2+$4,$2+$4+$5}' /proc/stat; sleep 1)" '/cpu /{split(a,b," "); print 100*($2+$4-b[1])/($2+$4+$5-b[2])}'  /proc/stat


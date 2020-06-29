#!/bin/sh
Jmeter=/opt/apache-jmeter-5.1.1/bin/jmeter
ScriptDir=/opt/www/testscripts/
ScriptName=
ScriptNum="
280
"

for script in `echo "$ScriptNum"|grep -vE "^#"`;do
   targetnamenum=`grep -wn "ThreadGroup.num_threads" $ScriptDir/$ScriptName.jmx | head -1 | cut -d ":" -f 1`
   gsed -i  "$targetnamenum c <stringProp name=\"ThreadGroup.num_threads\">$script</stringProp>" $ScriptDir/$ScriptName.jmx
   echo "$ScriptName.jmx-$script Waitting..."
   logDir="/opt/www/results/logs"
   reportDir="/opt/www/results/reports"
   timestamp=$(date +%Y%m%d%H%M%S)
   while true;do
       runstats=$(jps|grep ApacheJMeter.jar 2>/dev/null)
       if [ -z "$runstats" ];then
           echo "$(date) : $lastScript done."
           echo "$(date) : $ScriptName-$script start..."
           echo "$Jmeter -n -t $ScriptDir/$ScriptName.jmx -l $logDir/$ScriptName.jmx-$script-$timestamp.log"
           $Jmeter -n -t "$ScriptDir/$ScriptName.jmx" -l "$logDir/$ScriptName-$script-$timestamp.log" ;$Jmeter -g "$logDir/$ScriptName-$script-$timestamp.log" -o "$reportDir/$ScriptName-$script-$timestamp/"
           lastScript="$ScriptName.jmx-$script"
         break
       fi
       sleep 30
   done
done
exit


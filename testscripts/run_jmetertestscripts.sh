#!/bin/sh
# update by cc-cuijun 20200630 增加注释

# 配置jmeter路径，或直接把jmeter配置成环境变量。
Jmeter=/opt/apache-jmeter-5.1.1/bin/jmeter
# 配置jmx脚本路径
ScriptDir=/opt/www/testscripts/jmetertestscripts/
# 配置jmx文件名
ScriptName=test
# 配置线程数，该线程会替换jmx中指定的ThreadGroup.num_threads，支持配置多个，一行一个
ScriptNum="
100
150
200
250
300
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


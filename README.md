# 自动化性能测试框架

## 使用及配置方式：

step1. 修改配置脚本：
<pre>
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
</pre>

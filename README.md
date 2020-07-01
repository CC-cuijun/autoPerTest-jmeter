# 自动化性能测试框架

自己做了一套简易的自动化性能测试框架，利用shell+jmeter-5.1.1源码编译版本，为了满足部分测试场景编写了一些插件和java请求，修改了源码中tcp连接部分，jmeter需安装性能测试插件，虽然在很多项目都实施过，但还是有很多可以优化的空间，若没有特殊需求，可使用编译好的jmeter版本，同时安装性能测试插件，使用过程中有不便或不满足场景的可电邮本人，或提交合并请求，共同学习，邮箱地址见README末尾。

## 自动化测试包目录介绍

    ├─ opt
        ├── www                          主文件目录
            ├── README.md                自述文件
            └── testscripts              jmeter测试主目录
                ├── run_jmetertestscripts.sh 主脚本        
                ├── run_logs                 运行日志文件目录
                ├── testData                 测试数据存放目录
                        └── test.csv         测试数据        
                ├── run.sh                   测试运行脚本
                └── jmetertestscripts        jmeter脚本文件
                        ├── xxx1.jmx                 脚本1
                        └── xxx2.jmx                 脚本2
             └── results          测试结果目录
                   ├── logs       jmeter原始日志
                   └── reports    html报告
               




## 使用及配置方式：

step1. 在本地调试好jmeter脚本；  
step2. 将脚本放在jmetertestscripts目录下；  
step3. 将脚本依赖的测试数据文件放到testdata目录下；  
step4. 修改run_jmetertestscripts.sh脚本：  
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

step5. 执行脚本 ./run.sh  
step6. 实时跟踪run_logs目录下的日志；  

## jmeter脚本编写规范
1. 为了减少不必要的资源开销，测试脚本中不需要指定保存测试结果文件，也不需要开启各类监听器;  
2. 为了确保测试结果的准确性，每条用例一定要设置正确的断言；  
3. 为了确保测试脚本的易维护性，测试脚本应做到用例名称清晰准，注释足够且准确，测试逻辑清晰，脚本整洁有序，删除不必要的测试控件或冗余的逻辑等，确保测试高效，脚本易读易维护；  

## 常见问题：
1. 测试数据读取不到。
   - 检查jmx脚本中的测试数据路径是否对应放到了testdata目录中；
2. 脚本读取报错。
   - 检查jmx脚本是否放到了jmetertestscripts目录中；
   - 检查run_jmetertestscripts.sh脚本配置的脚本名字ScriptName是否正确，注意脚本名不带.jmx
3. jmeter命令报错。
   - 检查jmeter路径是否配置正确，或jmeter环境变量是否配置正确；
4. 线程数替换失败。
   - 检查jmeter脚本是否规范，建议使用jp@gc - Steppig Thread Group
   - mac下sed命令与GNU不一致，在mac下需要安装GNU的sed：  
     > brew install gnu-sed  
     > 可在~/.zshrc中配置 alias sed=gsed  
     > 也可直接使用gsed命令，和linux下的sed一致
 
 > 使用中有任何问题请联系作者： E-mail：397176345@qq.com

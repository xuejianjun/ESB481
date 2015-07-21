# ESB481
ESB481汉化
-------------------------

### 准备工作：<br />
		wso2esb 4.8.1
		wso2esb 4.8.1的正式发布版本基于wso2carbon 4.2.0的以及 wso2platfrom 4.8.1 
		[carbon](https://svn.wso2.org/repos/wso2/carbon/kernel/branches/4.2.0)<br />源码地址：https://svn.wso2.org/repos/wso2/carbon/kernel/branches/4.2.0
		platfrom地址为：[https://svn.wso2.org/repos/wso2/carbon/platform/tags/turing-chunk07/](https://svn.wso2.org/repos/wso2/carbon/platform/tags/turing-chunk07/)<br />

### 汉化：<br />
		将wso2esb-4.8.1.zip，解压到本地目录，作为wso2esb-4.8.1的安装目录
		启动ESB之后，找到需要汉化的页面。
		例如：服务注册页面：https://localhost:9446/carbon/proxyservices/templates.jsp?region=region1&item=proxy_services_menu
		在下载的源码中寻找关键字，proxyservices，我们搜索proxyservices.找到对应jar包org.wso2.carbon.proxyadmin.ui，jar包钟找到对应的templates.jsp页面,在页面中我们往往可以看到这样的代码程序： 
		<fmt:bundle basename="org.wso2.carbon.proxyadmin.ui.i18n.Resources">，
		如此可以找到对应的国际化文件org.wso2.carbon.proxyadmin.ui.i18n.Resources。国际化文件中，我们可以找到类似的Resources.properties或者JSResources.properties文件，
		copy这些文件并修改文件名称为的Resources_zh_CN.properties/JSResources_zh_CN.properties,即添加文件后缀_zh_CN，同时汉化*_zh_CN.properties文件。

### 打包：<br />
		将修改后的文件编译打包，覆盖wso2esb-4.8.1安装目录下repository\components\plugins下原来jar包，最后运行安装目录的bin下的wso2server.bat即可。。
		ps：编译时可以在pom文件中引入公共仓库：
	 <repositories>
        <repository>
            <id>wso2-nexus</id>
            <name>WSO2 internal Repository</name>
            <url>http://maven.wso2.org/nexus/content/groups/wso2-public/</url>
            <releases>
                <enabled>true</enabled>
                <updatePolicy>daily</updatePolicy>
                <checksumPolicy>ignore</checksumPolicy>
            </releases>
        </repository>
    </repositories>


### 问题：<br />
		汉化的过程中，最后的结果往往会出现中文乱码，此时有二种方案：
		第一种是：把中文汉字修改成unicode编码格式。unicode编码转码地址：[http://www.cnblogs.com/mq0036/p/4007452.html](http://www.cnblogs.com/mq0036/p/4007452.html)<br />
		第二种是：直接在页面指定字符集为UTF-8. 页首加上
		<%@ page language="java" pageEncoding="UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		此外：WSO2系列产品的国际化做的并不是非常的标准有不少直接写在JSP页面中或者js文件中，这里就需要观众老爷们自己去找页面汉化了。

		ps：之前K神已经整理菜单与源文件的具体对应关系图，在此引用下：[http://m.blog.csdn.net/blog/szh1124/41745899](http://m.blog.csdn.net/blog/szh1124/41745899)<br />


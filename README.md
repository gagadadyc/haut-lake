# haut-lake
大三下暑期实训项目——旅游网站

## 运行环境及使用技术
	
	 - 编译器：IntelliJ IDEA
	 - 环境支持：JDK1.8、Java EE 7、Apache Tomcat 8.0.x
	 - 开发语言：Java、HTML、JavaScript、EL Expression
	 - 程序类型：Web类B/S应用程序
	 - 运用框架：Spring framework，Spring MVC，mybatis
	 - 开发工具：Maven
   
## 其他说明
本项目将数据库配置单独写在一个文件中，以便于管理。
该文件在/src/main/resources目录下，由于涉及数据库密码，上传时过滤掉了该文件，命名为：jdbc.properties ，源代码如下
```
jdbc.username = 
jdbc.password = 
jdbc.driverClassName=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://127.0.0.1:3306/haut?useUnicode=true&characterEncoding=UTF-8


#初始化连接
initialPoolSize=15

#最大连接数量
maxPoolSize=30

#最小链接数
minPoolSize=10
```

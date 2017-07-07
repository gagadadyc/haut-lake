# haut-lake
大三下暑期实训项目——旅游门户网站

## 运行环境及使用技术
	
	 - 编译器：IntelliJ IDEA
	 - 环境支持：JDK1.8、Java EE 7、Apache Tomcat 8.0.x
	 - 开发语言：Java、HTML、JavaScript、EL Expression
	 - 程序类型：Web类B/S应用程序
	 - 运用框架：Spring framework，Spring MVC，Mybatis
	 - 开发工具：Maven
	 
## 项目功能描述
本项目主要是对旅游网站的新闻、目录进行增删改查的功能，其中
- 新增功能的id字段使用自增长，发布时间字段使用当前时间作为默认值。
- 删除功能实际是使用UPDATE语句对删除时间字段进行标记、以此来区别未被删除的记录。支持批量删除。
- 修改功能使根据id值来修改记录
- 查询功能主要是将数据库中未被删除的记录展示给用户。

## 目录结构说明
本项目使用了Maven的webapp模板，如下图  
![https://wx3.sinaimg.cn/large/005OhOJ0ly1fhbdd0n0vjj30910e0mxb.jpg](https://wx3.sinaimg.cn/large/005OhOJ0ly1fhbdd0n0vjj30910e0mxb.jpg)  
main中是整体项目运行的代码、test中是测试（整体项目没有进行多少测试，唯一的一个测完还把代码删掉了(//▽//) ）。main中的代码主要分为java、resources、webapp三个文件夹，java中放的是java代码、resources放的是配置文件、webapp放的是网站文件。
在java文件夹中，我们的haut-lake项目就在com.imdyc.hautlake包中。hautlake包下有dao、entity、service、util、web五个子包，分别放的是持久层代码、模型层的实体类代码、业务类逻辑代码、工具类、SpringMVC的Controller。  
在resources文件夹中、有mapper、spring两个文件夹以及mybati的配置文件和数据库配置文件（数据库配置文件没有提交到github，在后面会有详细说明）。mapper文件夹放的是Mybatis的映射文件，与dao包中的类一一对应（映射文件的只配置了两个方法的映射语句，后面了解到了可以用注解代替映射文件，就用了注解，还没来得及将之前两个方法的映射语句改到注解中，另外批量删除功能需要<foreach>标签来实现动态的SQL语句支持，目前没有发现在注解中有代替的方法）。Spring文件夹下有spring-dao、spring-service、spring-web三个文件，spring-dao文件主要是数据库连接池和注入dao接口包的配置、spring-service和spring-web分别对应了spring-framework和spring-mvc的配置。  

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

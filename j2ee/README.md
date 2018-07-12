<!-- TOC -->

- [Versions](#versions)
- [Profile](#profile)
- [Servlet](#servlet)
- [EJB](#ejb)
- [application servers](#application-servers)
    - [Open Source](#open-source)
- [J2EE tutorial](#j2ee-tutorial)
- [glassfish](#glassfish)
- [IDE](#ide)
    - [IBM Rational Application Developer](#ibm-rational-application-developer)
    - [Eclipse](#eclipse)

<!-- /TOC -->

# Versions
|Release|Year|[Major Version](https://stackoverflow.com/questions/9170832/list-of-java-class-file-format-major-version-numbers)|
|---|---|---|
|J2SE 1.4|2002|48|
|J2SE 5.0|2004|49|
|Java SE 6|2006|50|
|Java SE 7|2011|51|
|Java SE 8|2014|52|
|Java SE 9|2017|53|
|Java SE 10 (18.3)|2018|54|

	J2EE 1.4 (November 11, 2003)
	Java EE 5 (May 11, 2006)
	Java EE 6 (December 10, 2009)
	Java EE 7 (June 12, 2013)
	Java EE 8 (September 21, 2017)

|Specification|Java EE 6[9]|Java EE 7[3]|Java EE 8[5]|
|---|---|---|---|
|Servlet|3|3.1|4|
|JavaServer Pages (JSP)|2.2|2.3|2.3|
|Unified Expression Language (EL)|2.2|3|3|
|JavaServer Faces (JSF)|2|2.2|2.3|
|Java API for RESTful Web Services (JAX-RS)|1.1|2|2.1|
|Java API for WebSocket (WebSocket)|n/a|1|1.1|
|Java API for JSON Processing (JSON-P)|n/a|1|1.1|
|Common Annotations for the Java Platform (JSR-250)|1.1|1.2|1.3|
|Enterprise JavaBeans (EJB)|3.1 Lite|3.2 Lite|3.2|
|Java Transaction API (JTA)|1.1|1.2|1.2|
|Java Persistence API (JPA)|2|2.1|2.2|
|Bean Validation|1|1.1|2|
|Interceptors|1.1|1.2|1.2|
|Contexts and Dependency Injection for the Java EE Platform|1|1.1|2|

# Profile
https://stackoverflow.com/questions/24239978/java-ee-web-profile-vs-java-ee-full-platform

![](https://i.stack.imgur.com/CybGj.png)

# Servlet
https://en.wikipedia.org/wiki/Java_servlet

|Servlet API version|Released|JSR Number|Platform|Important Changes|
|---|---|---|---|---|
|Servlet 4.0|Sep 2017|369|Java EE 8|HTTP/2|
|Servlet 3.1|May 2013|340|Java EE 7|Non-blocking I/O, HTTP protocol upgrade mechanism (WebSocket)[7]|
|Servlet 3.0|December 2009|315|Java EE 6, Java SE 6|Pluggability, Ease of development, Async Servlet, Security, File Uploading|
|Servlet 2.5|September 2005|154|Java EE 5, Java SE 5|Requires Java SE 5, supports annotation|
|Servlet 2.4|November 2003|154|J2EE 1.4, J2SE 1.3|web.xml uses XML Schema|

# EJB
![](http://assets.devx.com/articlefigs/JavaEE6Fig4.JPG)

# application servers
https://en.wikipedia.org/wiki/List_of_application_servers#Java

https://en.wikipedia.org/wiki/Java_Platform,_Enterprise_Edition#Certified_referencing_runtimes

## Open Source
https://github.com/javaee/glassfish  
https://github.com/wildfly/wildfly

# J2EE tutorial
https://javaee.github.io/firstcup/creating-example002.html

# glassfish
https://blogs.oracle.com/theaquarium/glassfish-docker-images-%E2%80%93-update

	docker run -ti -e ADMIN_PASSWORD=<your-secret-password> -p 4848:4848 -p 8080:8080 -d oracle/glassfish
	docker run -ti -p 4848:4848 -p 8080:8080 -d oracle/glassfish   # Auto Generated `admin` password

# IDE
## IBM Rational Application Developer
Tutorial: https://www.ibm.com/developerworks/rational/library/05/719_app/index.html

## Eclipse
eclipse.ini

	-vm
	path_to\jdk1.8.0_60\bin\javaw.exe
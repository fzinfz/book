<!-- TOC -->autoauto- [liberty](#liberty)auto- [License](#license)auto- [traditional](#traditional)autoauto<!-- /TOC -->

# liberty
https://www.ibm.com/support/knowledgecenter/en/SS7K4U_liberty/com.ibm.websphere.wlp.zseries.doc/ae/rwlp_feat.html

    docker run -d -p 80:9080 -p 443:9443 \
        -v /tmp/DefaultServletEngine/dropins/Sample1.war:/config/dropins/Sample1.war \
        websphere-liberty:webProfile7  # http://localhost/Sample1/SimpleServlet

[Liberty Profile Guide for Developers(PDF)](https://www.redbooks.ibm.com/redbooks/pdfs/sg248076.pdf)

https://www.ibm.com/developerworks/websphere/library/techarticles/1404_vines1/1404_vines1.html

![](https://www.ibm.com/developerworks/websphere/library/techarticles/1404_vines1/images/image001.png)

# License
since v8.5.5.5: 2G organisation-wide production for free


# traditional
https://developer.ibm.com/wasdev/downloads/#asset/WAS_traditional_for_Developers	

traditional Version 9.0: Using the product in test and production environments is allowed but limited to a combined 2 GB of JVM heap space across all instances of application servers for the licensee. 

File > Preferences 》 Add Repository

	https://www.ibm.com/software/repositorymanager/V9WASILAN
	https://www.ibm.com/software/repositorymanager/V9WASSupplements　(Optional)

Version 8.5 and 8.0: not supported for use in a production environment.

	docker run --name websphere -p 9043:9043 -p 9443:9443 -d ibmcom/websphere-traditional:profile
	docker exec websphere cat /tmp/PASSWORD 
	# https://localhost:9043/ibm/console/login.do?action=secure | user: wsadmin

[WAS V8.5 Administration and Configuration Guide for the Full Profile(PDF)](http://www.redbooks.ibm.com/redbooks/pdfs/sg248056.pdf)


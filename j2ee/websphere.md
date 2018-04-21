<!-- TOC -->

- [liberty](#liberty)
- [traditional](#traditional)

<!-- /TOC -->

# liberty
https://www.ibm.com/support/knowledgecenter/en/SS7K4U_liberty/com.ibm.websphere.wlp.zseries.doc/ae/rwlp_feat.html

    docker run -d -p 80:9080 -p 443:9443 \
        -v /tmp/DefaultServletEngine/dropins/Sample1.war:/config/dropins/Sample1.war \
        websphere-liberty:webProfile7  # http://localhost/Sample1/SimpleServlet

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
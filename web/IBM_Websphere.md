<!-- TOC -->

- [OS Compatibility](#os-compatibility)
- [License](#license)
- [IM](#im)
    - [imcl install](#imcl-install)
- [Books](#books)
    - [V8.5 Concepts, Planning, and Design Guide](#v85-concepts-planning-and-design-guide)
        - [3.1.4 Profiles](#314-profiles)
        - [3.1.5 Nodes, node agents, and node groups](#315-nodes-node-agents-and-node-groups)
    - [V8.5 Administration and Configuration Guide for the Full Profile](#v85-administration-and-configuration-guide-for-the-full-profile)
        - [29.5.5 Creating a WebSphere Application Server profile on a remote target](#2955-creating-a-websphere-application-server-profile-on-a-remote-target)
- [profiles](#profiles)
- [liberty](#liberty)
- [traditional](#traditional)

<!-- /TOC -->

# OS Compatibility
https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=1307977887217&osPlatform=Linux

	docker run -it --name WAS85 -v $PWD/WAS85:/WAS --net host \
		centos:6 /bin/bash

# License
since v8.5.5.5: 2G organisation-wide production for free

# IM

	IM/installc  -acceptLicense
	/opt/IBM/InstallationManager/eclipse/tools/imcl -version
	cat /etc/.ibm/registry/InstallationManager.dat

## imcl install

	/opt/IBM/InstallationManager/eclipse/tools/imcl help install

	/opt/IBM/InstallationManager/eclipse/tools/imcl \
	install com.ibm.websphere.ND.v85 \
	-acceptLicense \
	-installationDirectory /opt/IBM/WebSphere \
	-repositories ./repository.config
	
# Books
## V8.5 Concepts, Planning, and Design Guide  
https://www.redbooks.ibm.com/redbooks/pdfs/sg248022.pdf

### 3.1.4 Profiles

	Custom profile, also known as  Empty Node because it has no application server inside.

### 3.1.5 Nodes, node agents, and node groups

	A node agent is created automatically when you add (federate) a stand-alone application server node to a cell.


## V8.5 Administration and Configuration Guide for the Full Profile  
http://www.redbooks.ibm.com/redbooks/pdfs/sg248056.pdf

### 29.5.5 Creating a WebSphere Application Server profile on a remote target

	WAS_HOME=/opt/IBM/WAS85
	WAS_PROFILES_HOME=$WAS_HOME/profiles  # need full path!

	./manageprofiles.sh \
	-create -profileName dmgrpf \
	-profilePath $WAS_PROFILES_HOME/dmgrpf \
	-templatePath $WAS_HOME/profileTemplates/cell/dmgr \
	-enableAdminSecurity true \
	-adminUserName wasadm \
	-adminPassword $Password \
	-cellName wascell \
	-nodeName CellManager01 \
	-nodeProfilePath $WAS_PROFILES_HOME \
	-appServerNodeName Node01

	./manageprofiles.sh \
	-create -profileName appSvr3 \
	-profilePath $WAS_PROFILES_HOME/appSvr3 \
	-templatePath $WAS_HOME/profileTemplates/cell/default \
	-enableAdminSecurity true \
	-adminUserName wasadm \
	-adminPassword $Password \
	-cellName wascell \
	-nodeName CellManager01 \
	-nodeProfilePath $WAS_PROFILES_HOME \
	-appServerNodeName Node01 \
	-dmgrProfilePath $WAS_PROFILES_HOME/dmgrpf \
	-nodePortsFile $WAS_PROFILES_HOME/dmgrpf/properties/nodeportdef.props \
	-portsFile $WAS_PROFILES_HOME/dmgrpf/properties/portdef.props


# profiles

	./manageprofiles.sh -listProfiles

https://www.ibm.com/support/knowledgecenter/en/SS9JLE_8.2.2/com.ibm.itamesso.doc_8.2.2/Installation_Guide/tasks/bck_profiles_cmdline.html

	./stopManager.sh
	./manageprofiles.sh  -backupProfile -profileName dmgrpf \
		-backupFile /WAS/profiles/dmgrpf.zip
	./manageprofiles.sh  -restoreProfile -backupFile /opt/IBM/WebSphere/profiles/dmgrpf.zip # WAS_HOME should be the same
		
https://www.ibm.com/support/knowledgecenter/en/SS9JLE_8.2.0/com.ibm.itamesso.doc/tasks/creating_wasnd_profiles_cmdline.html

	./manageprofiles.sh -create 
	-profileName Custom01 \
	-profilePath fullPathTo/profiles/Custom01
	-templatePath fullPathTo/profileTemplates/managed
	-dmgrHost  $HOST_DMGR
	-dmgrPort  8879
	-dmgrAdminUserName wasadm
	-dmgrAdminPassword $Password

# liberty
https://www.ibm.com/support/knowledgecenter/en/SS7K4U_liberty/com.ibm.websphere.wlp.zseries.doc/ae/rwlp_feat.html

    docker run -d -p 80:9080 -p 443:9443 \
        -v /tmp/DefaultServletEngine/dropins/Sample1.war:/config/dropins/Sample1.war \
        websphere-liberty:webProfile7  # http://localhost/Sample1/SimpleServlet

[Liberty Profile Guide for Developers(PDF)](https://www.redbooks.ibm.com/redbooks/pdfs/sg248076.pdf)

https://www.ibm.com/developerworks/websphere/library/techarticles/1404_vines1/1404_vines1.html

![](https://www.ibm.com/developerworks/websphere/library/techarticles/1404_vines1/images/image001.png)

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

	docker run --name was85 -h was85 \
	-v $(pwd)/PASSWORD:/tmp/PASSWORD \
	-p 9043:9043 -p 9443:9443 \
	-d --restart unless-stopped \
	ibmcom/websphere-traditional:8.5.5.14-profile

[WAS V8.5 Administration and Configuration Guide for the Full Profile(PDF)](http://www.redbooks.ibm.com/redbooks/pdfs/sg248056.pdf)



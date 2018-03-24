<!-- TOC -->

- [SNMP](#snmp)
- [Monitoring](#monitoring)
    - [Nagios - C](#nagios---c)
    - [Zabbix - C/PHP/JAVA](#zabbix---cphpjava)
        - [Docker](#docker)
    - [Elastic](#elastic)
        - [Beats - Go](#beats---go)
        - [alert](#alert)
    - [TICK stack](#tick-stack)
    - [Pandora FMS - PHP/Perl](#pandora-fms---phpperl)
    - [Cacti - PHP](#cacti---php)
    - [open-falcon - Go/JS](#open-falcon---gojs)
    - [Munin - Perl/Shell](#munin---perlshell)
    - [netdata - C/Python/JS/Shell](#netdata---cpythonjsshell)
- [Management](#management)
    - [Ansible - Python](#ansible---python)
    - [Puppet - Ruby](#puppet---ruby)
    - [Chef - Ruby](#chef---ruby)
    - [SaltStack - Python](#saltstack---python)
    - [Fabric - Python 2](#fabric---python-2)
- [CI](#ci)
    - [Jenkins - JAVA](#jenkins---java)
    - [Travis - Ruby/JS](#travis---rubyjs)

<!-- /TOC -->

# SNMP
https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol

v1: Authentication of clients is performed only by a "community string", in effect a type of password, which is transmitted in cleartext.  
v2c comprises SNMPv2 without the controversial new SNMP v2 security model, using instead the simple community-based security scheme of SNMPv1. incompatible with SNMPv1 in two key areas: message formats and protocol operations.   
v2u: greater security than SNMPv1, but without incurring the high complexity of SNMPv2.  
v3 primarily added security and remote configuration enhancements to SNMP.

the agent connects to the server on port 162  
port 161 on the agent side is used for queries

![](https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/SNMP_communication_principles_diagram.PNG/1000px-SNMP_communication_principles_diagram.PNG)

# Monitoring
## Nagios - C
https://github.com/NagiosEnterprises/nagioscore  
https://github.com/centreon/centreon  
https://github.com/NagVis/nagvis  

## Zabbix - C/PHP/JAVA
https://hub.docker.com/u/zabbix/  

### Docker
https://www.zabbix.com/documentation/3.4/manual/installation/containers#structure

Example 1: MySQL database support, Zabbix web interface based on the Nginx web server and Zabbix Java gateway.  
Example 2: PostgreSQL database support, Zabbix web interface based on the Nginx web server and SNMP trap feature.

Default login: Admin/zabbix

    docker run --name some-zabbix-agent \
        -e ZBX_SERVER_HOST="192.168.88.62" \
        --privileged -d \
        zabbix/zabbix-agent

    zabbix_agentd.exe -i --config path\to\zabbix_agentd.win.conf

## Elastic
### Beats - Go
https://www.elastic.co/products/beats  
https://github.com/elastic/beats  

    Filebeat    Log Files Beats
    Metricbeat  Metrics Beats
    Packetbeat  Network Data Beats
    Winlogbeat  Windows Event Logs Beats
    Auditbeat   Audit Data Beats
    Heartbeat   Uptime Monitoring

### alert
https://github.com/Yelp/elastalert
https://github.com/sirensolutions/sentinl

https://sematext.com/blog/x-pack-alternatives/

## TICK stack
https://gist.github.com/travisjeffery/43f424fbd7ac677adbba304cef6eb58f

|Component|Role|
|---|---|
|Telegraf|Data collector|
|InfluxDB|Stores data|
|Chronograf|Visualizer|
|Kapacitor|Alerter|

## Pandora FMS - PHP/Perl
https://github.com/pandorafms/pandorafms#screenshots

    # Auto docker
    curl -sSL http://pandorafms.org/getpandora  | sh  # Auto, or manually below

    # Manually
    docker run \
        --name pandora-mysql \
        -e MYSQL_ROOT_PASSWORD=AVeryStrongRootPassword \
        -e MYSQL_DATABASE=pandora \
        -e MYSQL_USER=pandora \
        -e MYSQL_PASSWORD=pandora
        -d pandorafms/pandorafms-mysql:6

    docker run -p 41121:41121 \
        --link pandora-mysql:mysql \
        -d pandorafms/pandorafms-server:6

    docker run \
        -p 80:80 -p 8022:8022 -p 8023:8023 \
        --link pandora-mysql:mysql \
        -d pandorafms/pandorafms-console:6

    apt install -y pandorafms-agent

## Cacti - PHP
https://github.com/Cacti/cacti

## open-falcon - Go/JS
https://github.com/open-falcon/falcon-plus/tree/master/docker

## Munin - Perl/Shell
networked resource monitoring tool  
http://munin-monitoring.org/  
http://guide.munin-monitoring.org/en/latest/tutorial/index.html  

## netdata - C/Python/JS/Shell
https://github.com/firehol/netdata (with screenshots)  
https://github.com/firehol/netdata/wiki/Installation

    bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh) 

# Management
## Ansible - Python
https://github.com/ansible/ansible  
using SSH, with no agents to install on remote systems.

https://www.ansible.com/blog/red-hat-ansible-automation-engine-vs-tower  
Check "What do I get?" section for comparison.

## Puppet - Ruby
https://hub.docker.com/u/puppet/  
https://puppet.com/docs # Puppet Enterprise vs Open Source

## Chef - Ruby
https://hub.docker.com/r/chef/chef/

## SaltStack - Python
https://github.com/saltstack/salt  
https://hub.docker.com/r/saltstack/

## Fabric - Python 2
https://github.com/fabric/fabric  
a Python (2.5-2.7) library and command-line tool for streamlining the use of SSH for application deployment or systems administration tasks.

# CI
## Jenkins - JAVA
https://github.com/jenkinsci/jenkins
![](https://jenkins.io/images/blueocean/blueocean-successful-pipeline.png)

## Travis - Ruby/JS
https://github.com/travis-ci/travis-ci
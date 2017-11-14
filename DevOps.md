<!-- TOC -->

- [Monitoring](#monitoring)
    - [Pandora FMS](#pandora-fms)
    - [Cacti - PHP](#cacti---php)
    - [Nagios - C](#nagios---c)
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

# Monitoring
## Pandora FMS
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

## Nagios - C
https://github.com/NagiosEnterprises/nagioscore

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
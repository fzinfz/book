<!-- TOC -->

- [IPMI](#ipmi)
  - [Dell idrac](#dell-idrac)
- [OS](#os)
  - [IBM Advanced Interactive eXecutive(AIX)](#ibm-advanced-interactive-executiveaix)
  - [IBM i](#ibm-i)
  - [HP-UX](#hp-ux)
- [Software](#software)
  - [IBM PowerVM](#ibm-powervm)
  - [IBM PowerKVM](#ibm-powerkvm)
  - [IBM PowerHA](#ibm-powerha)
  - [IBM PowerSC](#ibm-powersc)
- [IBM Power Systems](#ibm-power-systems)
- [IBM Power S8 series servers](#ibm-power-s8-series-servers)
- [IBM PurePower System](#ibm-purepower-system)

<!-- /TOC -->

# IPMI
## Dell idrac
virtual console: open port 443 + 5900 & java8\javaws.exe viewer.jnlp -verbose  
HKEY_CLASSES_ROOT\jnlp_auto_file\shell\open\command

    action=powerstatus # powerdown powerup graceshutdown hardreset powercycle
    ssh root@${host} "racadm serveraction ${action}"    

# OS
## IBM Advanced Interactive eXecutive(AIX)
https://en.wikipedia.org/wiki/IBM_AIX  
AIX 7.2(October 5, 2015) exploits POWER8 hardware features including accelerators and eight-way hardware multithreading.  
Live update for Interim Fixes, Service Packs and Technology Levels – replaces the entire AIX kernel without impacting applications  

## IBM i
runs on IBM Power Systems and on IBM PureSystems  
Version 7.3 was released in April 2016  
requiring little or no on-site attention from IT staff during normal operation

AIX programs are binary compatible with IBM i when using its PASE (Portable Applications System Environment)

## HP-UX
Latest release	11i v3 Update 16 / March 2017  

# Software
## IBM PowerVM
Available on IBM Power Systems™ servers and supported by the IBM AIX®, Linux® and IBM i operating systems

https://www.ibm.com/developerworks/community/blogs/fe313521-2e95-46f2-817d-44a4f27eba32/entry/Virtualization_Options_for_Power_Linux?lang=en  
PowerVM, which comes in standard and enterprise versions;  
PowerVM for PowerLinux only supports Linux and VIO Servers as guests and can run on any “L” model and is also the version provided in the Enterprise Systems IFLs.  PowerVM for PowerLinux is logically equivalent to PowerVM Enterprise Edition, and includes Live Partition Mobility.

PowerVP: Secure and scalable server virtualization environment for AIX, IBM i and Linux applications  
PowerVC: Advanced virtualization management and cloud management for Power Systems

## IBM PowerKVM
https://www.ibm.com/developerworks/community/blogs/fe313521-2e95-46f2-817d-44a4f27eba32/entry/Virtualization_Options_for_Power_Linux
only supported on the “L” models. NOT on the S824L GPU model, nor any POWER7 systems.  
PowerKVM does not support the pHyp interface, so OPAL (OpenPower Abstraction Layer), which is an alternative hardware interface, was created.  
order the system with PowerVM：get both the vet codes and machine code for PowerVM

https://www.ibm.com/developerworks/community/wikis/form/anonymous/api/wiki/61ad9cf2-c6a3-4d2c-b779-61ff0266d32a/page/1cb956e8-4160-4bea-a956-e51490c2b920/attachment/7a905bdf-5274-43ae-b5fd-3ef5bfc81f8a/media/AIX%20VUG%20-%20PowerKVM%20Overview.pdf

## IBM PowerHA
https://www-03.ibm.com/systems/power/software/availability/
Resiliency for AIX, Linux and IBM i  

## IBM PowerSC
Simplify security management and compliance measurement

# IBM Power Systems
previous generation: IBM System i

S821LC / S822LC
Runs Ubuntu, SUSE and Red Hat Linux
PowerVM and PowerKVM virtualization options

IBM Power S822, ESS, S812L, S822L and S824L
Configurable into highly scalable Linux clusters

E850C, E870C and E880C cloud models
• Runs AIX, IBM i and Linux

# IBM Power S8 series servers
for mid-size business.
Supports Linux, UNIX, and IBM i workloads

# IBM PurePower System
Based on open standards
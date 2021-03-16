<!-- TOC -->

- [Docs](#docs)
- [Videos](#videos)
- [Test Suites](#test-suites)
    - [Linux Test Project](#linux-test-project)
    - [LTP-DDT](#ltp-ddt)
    - [Android](#android)
    - [More](#more)
- [Test Automation Tools](#test-automation-tools)
    - [KernelCI - Python](#kernelci---python)
    - [LAVA - Linaro Automated Validation Architecture - Python](#lava---linaro-automated-validation-architecture---python)
    - [Fuego - Mitsubishi](#fuego---mitsubishi)
    - [labgrid - Python](#labgrid---python)
    - [r4d - Python](#r4d---python)
    - [Yocto project / ptest](#yocto-project--ptest)
    - [Selftests](#selftests)
        - [KUnit](#kunit)
    - [More](#more-1)
- [Static Analysis](#static-analysis)
- [Papers](#papers)

<!-- /TOC -->

# Docs
https://elinux.org/Testing  
https://elinux.org/Test_Systems#Test_Projects

http://events17.linuxfoundation.org/sites/events/files/slides/PRE-trunk-ELCE-Automation-beyond-Testing_1.pdf

# Videos
https://www.youtube.com/watch?v=NRywFwe0uwU  
introduce multiple frameworks available to test your Embedded Linux System and compare the use-cases 

"The magical fantasy land of Linux kernel testing" - Russell Currey (LCA 2020): https://www.youtube.com/watch?v=9Fzd6MapG3Y

# Test Suites
## Linux Test Project
https://github.com/linux-test-project/ltp/wiki

## LTP-DDT
https://software-dl.ti.com/processor-sdk-linux/esd/docs/latest/AM335X/linux/Foundational_Components_Kernel_LTP-DDT_Validation.html

## Android
https://android.googlesource.com/platform/external/ltp/

## More

    blktests
    kselftest - See notes at kselftest Notes
    xfstests
    
# Test Automation Tools
## KernelCI - Python
https://kernelci.org/ |  Linux Foundation project  
use LAVA with KernelCI: https://github.com/kernelci/kernelci-core/blob/main/doc/lava.md

## LAVA - Linaro Automated Validation Architecture - Python
https://www.lavasoftware.org/  
Source: https://git.lavasoftware.org/lava/lava

## Fuego - Mitsubishi
https://elinux.org/images/d/d4/ELCE-2016-Continuous-Integration-and-Autotest-Environment-using-Fuego_Master.pdf  

https://elinux.org/images/6/6c/Introduction-to-Fuego-JJ58-1.pdf  
Fuego = (Jenkins + abstraction scripts + pre-packaged tests) inside a container

[Video] Introduction to the Fuego Test System: https://www.youtube.com/watch?v=AueBSRN4wLk

Source: https://bitbucket.org/fuegotest/

## labgrid - Python
https://github.com/labgrid-project/labgrid#purpose  
create an abstraction of the hardware control layer needed for testing of embedded systems, automatic software installation and automation during development

- pytest plugin to write tests for embedded systems connecting serial console or SSH
- remote client-exporter-coordinator infrastructure to make boards available from different computers on a network
- power/reset management via drivers for power switches or onewire PIOs
- upload of binaries via USB: imxusbloader/mxsusbloader (bootloader) or fastboot (kernel)

Labgrid itself is not a testing framework, but is intended to be combined with pytest (and additional pytest plugins).

## r4d - Python
https://github.com/ci-rt/r4d  
r4d means 'Remote For Device-under-test' and is an infrastructure for power-control and console access for multiple Linux Boards that should be controlled by a test-infrastructure like jenkins.

## Yocto project / ptest
https://wiki.yoctoproject.org/wiki/Ptest  
Source: http://git.yoctoproject.org/clean/cgit.cgi/poky/tree/

## Selftests
https://www.kernel.org/doc/html/v4.15/dev-tools/kselftest.html

    fault-injection  
    ktest  
    kunit  
    nvdimm  
    radix-tree  
    scatterlist  
    selftests  
    vsock

### KUnit 
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html

## More
http://fuegotest.org/wiki/Other_test_systems

https://elinux.org/Test_Stack_Survey#Responses  

    0-day
    buildbot
    ci-rt (uses r4d) - realtime test system used by Linutronix
    CKI - used by RedHat

    Gentoo Kernel CI
    hottest notes
    Jenkins ??? (no one is specifically representing Jenkins at the summit)
    KernelCI
    kerneltests
    Krzk Samsung-SoC
    Kselftest
    ktest    
    Labgrid
    LKFT
    LTP
    Opentest
    Phoronix
    SLAV
    syzbot (& syzkaller)
    tbot
    TCF
    Xilinx test (aka regression_xlnx)

# Static Analysis

    Sparse
    Smatch
    clang

# Papers
Fuzz: https://ftp.cs.wisc.edu/paradyn/technical_papers/fuzz.pdf
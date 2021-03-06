<!-- TOC -->

- [Compare](#compare)
    - [Docs](#docs)
    - [Videos](#videos)
- [Test Suites](#test-suites)
    - [Linux Test Project](#linux-test-project)
    - [LTP-DDT](#ltp-ddt)
    - [Android](#android)
    - [dev-tools](#dev-tools)
        - [Selftests](#selftests)
        - [KUnit - Kernel Unit Testing Framework](#kunit---kernel-unit-testing-framework)
    - [Storage](#storage)
        - [xfstests](#xfstests)
        - [blktests](#blktests)
- [Test Automation Tools](#test-automation-tools)
    - [0Day](#0day)
    - [KernelCI - Python](#kernelci---python)
    - [LAVA - Python](#lava---python)
    - [Fuego - Mitsubishi](#fuego---mitsubishi)
    - [U-Boot “pytest suite”](#u-boot-pytest-suite)
    - [tbot - Python](#tbot---python)
    - [labgrid - Python](#labgrid---python)
    - [r4d - Python](#r4d---python)
    - [Yocto project / ptest](#yocto-project--ptest)
    - [Kerneltests.org](#kerneltestsorg)
    - [Robot Framework - Python](#robot-framework---python)
    - [More](#more)
- [Static Code Analyzers](#static-code-analyzers)
    - [Sparse](#sparse)
    - [clang / LLVM](#clang--llvm)
    - [Coccinelle](#coccinelle)
    - [smatch](#smatch)
    - [Coverity](#coverity)
- [Fuzzing Tools](#fuzzing-tools)
    - [Trinity](#trinity)
    - [Syzcaller](#syzcaller)
    - [kcov - code coverage for fuzzing](#kcov---code-coverage-for-fuzzing)

<!-- /TOC -->

# Compare
## Docs
https://elinux.org/Testing  
https://elinux.org/Test_Systems#Test_Projects  
https://elinux.org/images/9/9f/Linux-Kernel-Testing-Where-are-we.pdf  (2016)
http://events17.linuxfoundation.org/sites/events/files/slides/PRE-trunk-ELCE-Automation-beyond-Testing_1.pdf (2017)

## Videos
https://www.youtube.com/watch?v=NRywFwe0uwU  
introduce multiple frameworks available to test your Embedded Linux System and compare the use-cases (2018)  
Slide: https://elinux.org/images/0/08/Primer-Testing-Your-Embedded-System-What-is-a-ptest-Lava-Fuego-KernelCI-and...-Jan-Simon-Moeller-The-Linux-Foundation.pdf

# Test Suites
## Linux Test Project
https://github.com/linux-test-project/ltp/wiki

http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.2

    runltp
        filesystem stress tests
        disk I/O tests
        memory management stress tests
        ipc stress
        scheduler tests
        commands functional varification tests
        system call functional varification tests
    networktests.sh
        networking related tests
    diskio.sh
        tests related to floppy and CD-ROM drives

## LTP-DDT
https://software-dl.ti.com/processor-sdk-linux/esd/docs/latest/AM335X/linux/Foundational_Components_Kernel_LTP-DDT_Validation.html  
LTP-DDT focuses on embedded device driver tests.

## Android
https://android.googlesource.com/platform/external/ltp/

## dev-tools
https://www.kernel.org/doc/html/latest/dev-tools/

### Selftests
https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

    cd /linux/tools/testing/
    fault-injection  
    ktest  
    kunit  
    nvdimm  
    radix-tree  
    scatterlist  
    selftests  
    vsock

    make -C selftests
    make -C selftests run_tests

"The magical fantasy land of Linux kernel testing" - Russell Currey (LCA 2020): https://www.youtube.com/watch?v=9Fzd6MapG3Y

### KUnit - Kernel Unit Testing Framework
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html    

## Storage
### xfstests
https://kernel.googlesource.com/pub/scm/fs/ext2/xfstests-bld/+/HEAD/Documentation/what-is-xfstests.md  

    xfs, ext2, ext4, cifs, btrfs, f2fs, reiserfs, gfs, jfs, udf, nfs, tmpfs

### blktests
https://github.com/osandov/blktests  
https://zonedstorage.io/tests/blktests/

|Group name|Description|
|---|---|
|block|Block layer generic tests|
|loop|Loopback device tests|
|meta|blktests self tests|
|nbd|Network block device driver tests|
|nvme|NVMe driver tests|
|nvmeof-mp|NVME-over-fabrics multipath tests|
|scsi|SCSI layer tests|
|srp|SCSI RDMA Protocol driver tests|
|zbd|Zoned block device tests|

# Test Automation Tools
## 0Day
test suites used by 0-Day performance test and LKP test tool: 
https://01.org/lkp/documentation/0-day/lkp-test-suites-description

## KernelCI - Python
https://kernelci.org/ |  Linux Foundation project  
use LAVA with KernelCI: https://github.com/kernelci/kernelci-core/blob/main/doc/lava.md

## LAVA - Python
Linaro Automated Validation Architecture | https://www.lavasoftware.org/  
Source: https://git.lavasoftware.org/lava/lava  
Docker: https://github.com/kernelci/lava-docker/  

## Fuego - Mitsubishi
https://elinux.org/images/6/6c/Introduction-to-Fuego-JJ58-1.pdf  
Fuego = (Jenkins + abstraction scripts + pre-packaged tests) inside a container

https://elinux.org/images/d/d4/ELCE-2016-Continuous-Integration-and-Autotest-Environment-using-Fuego_Master.pdf  

Source: https://bitbucket.org/fuegotest/

Introduction Videos: 
- 53min https://www.youtube.com/watch?v=AueBSRN4wLk   
- 28min https://www.youtube.com/watch?v=2bSqzhTxLdU

## U-Boot “pytest suite”
https://github.com/u-boot/u-boot/tree/master/test/py  
only for U-Boot (with build support)

## tbot - Python
https://tbot.tools/  
https://github.com/Rahix/tbot  
allow running tests in an automated setting (CI).

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
Ptest (package test) is a concept for building, installing and running the test suites that are included in many upstream packages, and producing a consistent output format for the results.  
Source: http://git.yoctoproject.org/clean/cgit.cgi/poky/tree/

## Kerneltests.org
Created to test stable release candidates   
https://kerneltests.org/builders  

## Robot Framework - Python
http://robotframework.org/robotframework/#user-guide

OperatingSystem | Process | Dialogs / String | Telnet

## More
http://fuegotest.org/wiki/Other_test_systems

https://elinux.org/Test_Stack_Survey#Responses  

    kisskb    
    Olof's autobuilder: mainline and next for arm, arm64, powerpc
    Olof's autobooter:  mainline, next, arm-soc
    Tegra builds: mainline
    Buildbot by Mark Brown: x86_64, arm, arm64 (8 builds)
    CKI - used by RedHat
    Gentoo Kernel CI
    hottest notes
    Krzk Samsung-SoC
    ktest    
    Labgrid
    LKFT
    Opentest
    Phoronix
    SLAV
    syzbot (& syzkaller)
    TCF
    Xilinx test (aka regression_xlnx)

# Static Code Analyzers
## Sparse
https://www.kernel.org/doc/html/latest/dev-tools/sparse.html

https://sparse.docs.kernel.org/en/latest/  
the semantic parser, provides a compiler frontend capable of parsing most of ANSI C as well as many GCC extensions, and a collection of sample compiler backends, including a static analyzer also called sparse.

## clang / LLVM
https://clang-analyzer.llvm.org/  
the analyzer is part of Clang

## Coccinelle
https://coccinelle.gitlabpages.inria.fr/website/

## smatch
https://github.com/error27/smatch  
a semantic parser of source files
    
## Coverity
Commercial Static Analyzer： https://scan.coverity.com/o/oss_success_stories

# Fuzzing Tools
Paper: https://ftp.cs.wisc.edu/paradyn/technical_papers/fuzz.pdf

## Trinity
https://github.com/kernelslacker/trinity  
a system call fuzzer which employs some techniques to
pass semi-intelligent arguments to the syscalls being called.

## Syzcaller
https://github.com/google/syzkaller/blob/master/docs/internals.md  
- Net: https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_network.md
- USB: https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

## kcov - code coverage for fuzzing
https://www.kernel.org/doc/html/latest/dev-tools/kcov.html  
kcov exposes kernel code coverage information in a form suitable for coverage- guided fuzzing (randomized testing)

https://www.netbsd.org/~kamil/Maciej_Grochowski-FS_Fuzzing_EuroBSDCon2019.pdf
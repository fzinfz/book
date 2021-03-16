<!-- TOC -->

- [Compare](#compare)
    - [Docs](#docs)
    - [Videos](#videos)
- [Test Suites](#test-suites)
    - [Linux Test Project](#linux-test-project)
    - [LTP-DDT](#ltp-ddt)
    - [Android](#android)
    - [xfstests](#xfstests)
    - [More](#more)
    - [Selftests](#selftests)
        - [KUnit](#kunit)
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
    - [More](#more-1)
- [Static Code Analyzers](#static-code-analyzers)
    - [Coccinelle](#coccinelle)
    - [smatch](#smatch)
    - [Sparse](#sparse)
    - [clang / LLVM](#clang--llvm)
    - [Coverity](#coverity)
- [Fuzzing Tools](#fuzzing-tools)
    - [Trinity](#trinity)
    - [Syzcaller](#syzcaller)

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

## LTP-DDT
https://software-dl.ti.com/processor-sdk-linux/esd/docs/latest/AM335X/linux/Foundational_Components_Kernel_LTP-DDT_Validation.html

## Android
https://android.googlesource.com/platform/external/ltp/

## xfstests
https://kernel.googlesource.com/pub/scm/fs/ext2/xfstests-bld/+/HEAD/Documentation/what-is-xfstests.md  

    xfs, ext2, ext4, cifs, btrfs, f2fs, reiserfs, gfs, jfs, udf, nfs, tmpfs

## More

    blktests

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

"The magical fantasy land of Linux kernel testing" - Russell Currey (LCA 2020): https://www.youtube.com/watch?v=9Fzd6MapG3Y

### KUnit 
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html    
    
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

## Kerneltests.org
Created to test stable release candidates   
https://kerneltests.org/builders  

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
    tbot
    TCF
    Xilinx test (aka regression_xlnx)

# Static Code Analyzers
## Coccinelle
https://coccinelle.gitlabpages.inria.fr/website/

## smatch
https://github.com/error27/smatch  
a semantic parser of source files

## Sparse
https://sparse.docs.kernel.org/en/latest/  
the semantic parser, provides a compiler frontend capable of parsing most of ANSI C as well as many GCC extensions, and a collection of sample compiler backends, including a static analyzer also called sparse.
    
## clang / LLVM
https://llvm.org/docs/GettingStarted.html#overview  
Tools include an assembler, disassembler, bitcode analyzer, and bitcode optimizer. It also contains basic regression tests.

## Coverity
Commercial Static Analyzer： https://scan.coverity.com/o/oss_success_stories

# Fuzzing Tools
https://ftp.cs.wisc.edu/paradyn/technical_papers/fuzz.pdf

## Trinity
https://github.com/kernelslacker/trinity  
a system call fuzzer which employs some techniques to
pass semi-intelligent arguments to the syscalls being called.

## Syzcaller
https://github.com/google/syzkaller/blob/master/docs/internals.md  
- Net: https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_network.md
- USB: https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md
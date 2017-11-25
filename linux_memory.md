<!-- TOC -->

- [Memory Management Unit (MMU)](#memory-management-unit-mmu)
- [kmalloc & vmalloc](#kmalloc--vmalloc)
- [System Management Mode (SMM)](#system-management-mode-smm)
- [Memory Map](#memory-map)
    - [system memory](#system-memory)
        - [Legacy Region](#legacy-region)
    - [Firmware Perspective - Platform Initialization (PI) specification](#firmware-perspective---platform-initialization-pi-specification)
        - [Pre-EFI-initialization (PEI) phase](#pre-efi-initialization-pei-phase)
        - [Driver eXecution Environment (DXE) Phase](#driver-execution-environment-dxe-phase)
    - [OS Perspective](#os-perspective)
- [free](#free)
- [dmesg](#dmesg)
- [/proc/iomem](#prociomem)
- [/proc/vmallocinfo](#procvmallocinfo)

<!-- /TOC -->

# Memory Management Unit (MMU)
https://cseweb.ucsd.edu/classes/su09/cse120/lectures/Lecture7.pdf

    MMU translates the virtual address into the physical RAM address 
    Paging solves the external fragmenta>on problem by using fixed sized 
    units in both physical and virtual memory
    The address “0x1000” maps to different physical addresses in different 
    processes 

    # P23 => diagram
    Virtual address = VPN :: offset
        Virtual page number (VPN) is an index into a page table
        Page table determines page frame number (PFN)
    Physical address = PFN :: offset

    Memory address is 32 bits   # 2^32 = 4 294 967 296
    • Pages are 4K              # 2^12 = 4 096
        => VPN is   20    bits (   1M  VPNs), offset is   12  bits  # 2^20 = 1 048 576
    • Virtual address is 0x7468         # 0b ... ‭0111 / 0100 0110 1000‬
        => Virtual page is    0x7 , offset is _0x468__
    • Page table entry  _0x7_  contains 0x2
    – Page frame base is 0x2 <<     12     bits =__0x2000__ 
    – ___7_th virtual page is address 0x2000 (3rd physical page) 
    • Physical address = _0x2000_ + _0x468_ =  _0x2468_

# kmalloc & vmalloc
https://static.lwn.net/images/pdf/LDD3/ch08.pdf

    `kmalloc` is fast (unless it blocks) and 
    doesn’t clear the memory it obtains; the allocated region still holds its previous content.* 
    The allocated region is also contiguous in physical memory. 

    `vmalloc` allocates a contiguous memory region in the virtual address space. 
    Although the pages are not consecutive in physical memory (each page is retrieved with a separate call to alloc_page),
    the kernel sees them as a contiguous range of addresses. 
    vmalloc returns 0 (the NULL address) if an error occurs, 
    otherwise, it returns a pointer to a linear memory area of size at least size.

# System Management Mode (SMM)
http://invisiblethingslab.com/resources/misc09/smm_cache_fun.pdf

    SMM is the most privileged CPU operation mode on x86/x86_64 architectures. 
    code lives in SMRAM. 
    limit access to SMRAM memory only to system ﬁrmware (BIOS). 
    after loading the SMM code into SMRAM, can (and should) later "lock down" system conﬁguration..., even for an OS kernel (or a hypervisor). 

# Memory Map
https://firmware.intel.com/sites/default/files/resources/A_Tour_Beyond_BIOS_Memory_Map_in%20UEFI_BIOS.pdf

    Typical memory map includes the storage accessed by processor directly.
    1) Physical memory. E.g. main memory, SMRAM (SMM stolen memory), integrated graphic stolen memory.
    2) Memory Mapped IO.

## system memory
    the main dynamic random access memory (DRAM)
    1) Legacy region less-than 1MiB
    2) Main memory between 1MiB and 4GiB
    3) Main memory great-than 4GiB

### Legacy Region
    for legacy OS or device consideration. 
     0–640KiB (0-0xA0000): DOS Area. (normally) for legacy OS (DOS) or boot loader usage.
     640–768KiB (0xA0000-0xC0000): SMRAM/Legacy Video Buffer Area. This region can
    be configured as SMM memory, or mapped IO for legacy video buffer.
     768–896KiB (0xC0000-0xE0000): Expansion Area for legacy option ROM. This region
    is DRAM and could be locked to be read-only.
     896KiB–1MiB (0xE0000-0x100000): System BIOS Area. This region could be DRAM
    or could be configured as memory IO to flash region.

## Firmware Perspective - Platform Initialization (PI) specification
### Pre-EFI-initialization (PEI) phase
no memory map term in PEI phase. The “memory map” concept is reported by in PEI Hand-of-Block (HOB).

### Driver eXecution Environment (DXE) Phase
Global Coherency Domain Services (GCD) are used to manage the memory and I/O resources visible to the boot processor, including GCD memory space map, and GCD IO space map.

## OS Perspective
GetMemoryMap() interface returns an array of UEFI memory descriptors.  
no UEFI memory map for S3 resume, because S3 resume only has PEI phase.  
The memory map should NOT be changed in S4 resume phase, because OS restores the system memory from disk directly.  

legacy ACPI specification: INT15 E820H function call, or E820 table. 

The difference is that E820 table does not have runtime concept,  
so memory mapped I/O and memory mapped I/O port space allowed for virtual mode calls to UEFI run-time functions does not exist.

# free
                total        used        free      shared  buff/cache   available
    Mem:       23596328     4675168    10635496       74832     8285664    18466200
    Swap:       1511420           0     1511420

# dmesg
```
grep -i efi
[    0.000000] efi: EFI v2.50 by American Megatrends
[    0.363043] pci 0000:00:02.0: BAR 2: assigned to efifb   
[    0.368065] Registered efivars operations
[    0.903316] efifb: probing for efifb     # efifb is only for EFI booted Intel Macs
[    0.903324] efifb: framebuffer at 0xc0000000, using 3072k, total 3072k
[    0.903325] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    0.903326] efifb: scrolling: redraw
[    0.903327] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.905314] fb0: EFI VGA frame buffer device
[    1.098604] EFI Variables Facility v0.08 2004-May-17
[    1.324444] fb: switching to inteldrmfb from EFI VGA # inteldrmfb: intel drm frame buffer

grep e820
[    0.000000] e820: BIOS-provided physical RAM map:

[    0.000000] e820: last_pfn = 0x66e000 max_arch_pfn = 0x400000000	# ‭2^34 = 17 179 869 184‬
[    0.000000] e820: last_pfn = 0x4f400 max_arch_pfn = 0x400000000
```

# /proc/iomem
with related e820/efi/ACPI dmesg
```
00000000-00000fff : Reserved                #     4 095    0b          ‭1111 1111 1111‬
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
00001000-00057fff : System RAM              # ‭  360 447‬    0b‭0101 0111 1111 1111 1111‬
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable

00058000-00058fff : Reserved                # ‭  364 543‬    0b‭0101 1000 1111 1111 1111‬
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.425875] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
00059000-0009dfff : System RAM              # ‭  647 167‬    0b‭1001 1101 1111 1111 1111‬
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable

0009e000-000fffff : Reserved                # ‭1 048 575 ‬   0b‭1111 1111 1111 1111 1111‬
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved  # ‭-401 407‬
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable                  # -‭393 215‬
[    0.425876] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]             # -  8 191
  000a0000-000bffff : PCI Bus 0000:00
  000c0000-000c3fff : PCI Bus 0000:00
  000c4000-000c7fff : PCI Bus 0000:00
  000c8000-000cbfff : PCI Bus 0000:00
  000cc000-000cffff : PCI Bus 0000:00
  000d0000-000d3fff : PCI Bus 0000:00
  000d4000-000d7fff : PCI Bus 0000:00
  000d8000-000dbfff : PCI Bus 0000:00
  000dc000-000dffff : PCI Bus 0000:00
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : PCI Bus 0000:00
    000f0000-000fffff : System ROM

00100000-3b77bfff : System RAM                     # ‭997 703 679‬, ‭-996 655 103‬
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003b77bfff] usable

3b77c000-3b77cfff : ACPI Non-volatile Storage      # ‭997 707 775‬, ‭-4 095‬
[    0.000000] BIOS-e820: [mem 0x000000003b77c000-0x000000003b77cfff] ACPI NVS  # -4 095‬
[    0.326856] PM: Registering ACPI NVS region [mem 0x3b77c000-0x3b77cfff] (4096 bytes)
[    0.425876] e820: reserve RAM buffer [mem 0x3b77c000-0x3bffffff]        # - ‭8 929 279‬
3b77d000-3b77dfff : Reserved                                                    # ‭-4 095‬
[    0.000000] BIOS-e820: [mem 0x000000003b77d000-0x000000003b77dfff] reserved
3b77e000-4e26cfff : System RAM                                            # ‭-313 454 591‬
[    0.000000] BIOS-e820: [mem 0x000000003b77e000-0x000000004e26cfff] usable

4e26d000-4e5adfff : Reserved                        # ‭1 314 578 431‬       ‭ -3 411 967‬
[    0.000000] BIOS-e820: [mem 0x000000004e26d000-0x000000004e5adfff] reserved
[    0.425877] e820: reserve RAM buffer [mem 0x4e26d000-0x4fffffff]     # ‭-31 010 815‬
4e5ae000-4ea1afff : System RAM                      ‭# 1 319 219 199‬       ‭ -4 640 767‬
[    0.000000] BIOS-e820: [mem 0x000000004e5ae000-0x000000004ea1afff] usable
[    0.000000] efi:  ACPI 2.0=0x4ea1b000  ACPI=0x4ea1b000  SMBIOS=0x4f2cf000  ESRT=0x4a4393d8 
4ea1b000-4edf1fff : ACPI Non-volatile Storage       # ‭1 323 245 567‬        ‭-4 026 367‬
[    0.000000] BIOS-e820: [mem 0x000000004ea1b000-0x000000004edf1fff] ACPI NVS
[    0.000000] ACPI: UEFI 0x000000004EA4AEA0 000042 (v01 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: RSDP 0x000000004EA1B000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000004EA1B0A8 0000CC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000004EA43908 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x000000004EA1B208 028700 (v02 ALASKA A M I    01072009 INTL 20160422)
[    0.000000] ACPI: FACS 0x000000004EDF1C40 000040
[    0.000000] ACPI: APIC 0x000000004EA43A20 000084 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000004EA43AA8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000004EA43AF0 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x000000004EA43B30 0003BC (v01 SataRe SataTabl 00001000 INTL 20160422)
[    0.000000] ACPI: FIDT 0x000000004EA43EF0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000004EA43F90 003159 (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.000000] ACPI: SSDT 0x000000004EA470F0 00255F (v02 PegSsd PegSsdt  00001000 INTL 20160422)
[    0.000000] ACPI: HPET 0x000000004EA49650 000038 (v01 INTEL  SKL      00000001 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x000000004EA49688 000DE5 (v02 INTEL  Ther_Rvp 00001000 INTL 20160422)
[    0.000000] ACPI: SSDT 0x000000004EA4A470 000A2A (v02 INTEL  xh_rvp08 00000000 INTL 20160422)
[    0.000000] ACPI: UEFI 0x000000004EA4AEA0 000042 (v01 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x000000004EA4AEE8 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.000000] ACPI: LPIT 0x000000004EA4BDC8 000094 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.000000] ACPI: WSMT 0x000000004EA4BE60 000028 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x000000004EA4BE88 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.000000] ACPI: SSDT 0x000000004EA4C128 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.000000] ACPI: DBGP 0x000000004EA4F130 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.000000] ACPI: DBG2 0x000000004EA4F168 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.000000] ACPI: DMAR 0x000000004EA4F1C0 0000A8 (v01 INTEL  SKL      00000001 INTL 00000001)
[    0.326856] PM: Registering ACPI NVS region [mem 0x4ea1b000-0x4edf1fff] (4026368 bytes)
[    0.425877] e820: reserve RAM buffer [mem 0x4ea1b000-0x4fffffff]     # ‭-22 958 079‬
4edf2000-4f39cfff : Reserved                        # ‭1 329 188 863‬        -5 943 295‬
[    0.000000] BIOS-e820: [mem 0x000000004edf2000-0x000000004f39cfff] reserved
4f39d000-4f3fefff : Unknown E820 type               # ‭1 329 590 271‬    ‭      -401 407‬
[    0.000000] BIOS-e820: [mem 0x000000004f39d000-0x000000004f3fefff] type 20
4f3ff000-4f3fffff : System RAM                      # ‭1 329 594 367‬          ‭  -4 095‬
[    0.000000] BIOS-e820: [mem 0x000000004f3ff000-0x000000004f3fffff] usable
4f400000-8fffffff : Reserved                        # ‭2 415 919 103‬    -1 086 324 735‬
[    0.425878] e820: reserve RAM buffer [mem 0x4f400000-0x4fffffff]     # ‭-12 582 911‬
[    0.000000] BIOS-e820: [mem 0x000000004f400000-0x000000008fffffff] reserved
  50000000-8fffffff : Graphics Stolen Memory        #    ‭              -1 073 741 823‬

90000000-dfffffff : PCI Bus 0000:00                 # ‭3 758 096 383‬
[    0.000000] e820: [mem 0x90000000-0xdfffffff] available for PCI devices
  90000000-901fffff : PCI Bus 0000:02
  90200000-903fffff : PCI Bus 0000:02
  c0000000-cfffffff : 0000:00:02.0
  d0000000-d00fffff : PCI Bus 0000:01
    d0000000-d000ffff : 0000:01:00.0
      d0000000-d000ffff : r8169
  de000000-deffffff : 0000:00:02.0
  df000000-df0fffff : PCI Bus 0000:03
    df000000-df003fff : 0000:03:00.0
      df000000-df003fff : r8169
    df004000-df004fff : 0000:03:00.0
      df004000-df004fff : r8169
  df100000-df1fffff : PCI Bus 0000:01
    df100000-df100fff : 0000:01:00.0
      df100000-df100fff : r8169
  df200000-df20ffff : 0000:00:1f.3
    df200000-df20ffff : ICH HD audio
  df210000-df21ffff : 0000:00:14.0
    df210000-df21ffff : xhci-hcd
  df220000-df223fff : 0000:00:1f.3
    df220000-df223fff : ICH HD audio
  df224000-df227fff : 0000:00:1f.2
  df228000-df229fff : 0000:00:17.0
    df228000-df229fff : ahci
  df22a000-df22a0ff : 0000:00:1f.4
  df22b000-df22b7ff : 0000:00:17.0
    df22b000-df22b7ff : ahci
  df22c000-df22c0ff : 0000:00:17.0
    df22c000-df22c0ff : ahci
  df22d000-df22dfff : 0000:00:16.0
    df22d000-df22dfff : mei_me
  df22e000-df22efff : 0000:00:14.2
    df22e000-df22efff : Intel PCH thermal driver
  df22f000-df22ffff : 0000:00:08.0
  dffc0000-dffdffff : pnp 00:08
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]       # ‭-268 435 455‬, PCI extended config space
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.328378] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
  e0000000-efffffff : Reserved
    e0000000-efffffff : pnp 00:08
fd000000-fe7fffff : PCI Bus 0000:00                                             # ‭-25 165 823‬
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved  # ‭-    69 631‬
  fd000000-fdabffff : pnp 00:09
  fdac0000-fdacffff : pnp 00:0b
  fdad0000-fdadffff : pnp 00:09
  fdae0000-fdaeffff : pnp 00:0b
  fdaf0000-fdafffff : pnp 00:0b
  fdb00000-fdffffff : pnp 00:09
  fe000000-fe010fff : Reserved
  fe036000-fe03bfff : pnp 00:09
  fe03d000-fe3fffff : pnp 00:09
fec00000-fec00fff : Reserved        # ‭4 273 999 871‬
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed00fff : Reserved        # ‭4 275 048 447‬
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
  fed00000-fed003ff : HPET 0
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
    fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:08
fed18000-fed18fff : pnp 00:08
fed19000-fed19fff : pnp 00:08
fed20000-fed3ffff : pnp 00:08
fed45000-fed8ffff : pnp 00:08
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC      # ‭4 276 097 023‬, -4 095
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] ACPI: Local APIC address 0xfee00000
  fee00000-fee00fff : Reserved
ff000000-ffffffff : Reserved        # ‭4 294 967 295‬, ‭-16 777 215‬
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:08
100000000-66dffffff : System RAM    # ‭27 615 297 535‬, ‭-23 320 330 239‬
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000066dffffff] usable
  4dcc00000-4dd512035 : Kernel code
  4dd512036-4ddc6963f : Kernel data
  4ddec9000-4de11dfff : Kernel bss
66e000000-66fffffff : RAM buffer    # ‭‭27 648 851 967‬, -33 554 431‬
[    0.425878] e820: reserve RAM buffer [mem 0x66e000000-0x66fffffff]
```

# /proc/vmallocinfo
```
0xffffb2a680000000 ~= ‭1.845×10^19 bits ~= 2EiB
0xffffffffc0cfe000 - 0xffffb2a680000000 = 0x4d5940cfe000  = 8.5045734793216 × 10^13

Addr                                     Diff
0xffffb2a680000000-0xffffb2a680002000    8192 hpet_enable+0x39/0x2ca phys=0x00000000fed00000 ioremap
0xffffb2a680002000-0xffffb2a680004000    8192 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea43000 ioremap
0xffffb2a680004000-0xffffb2a680006000    8192 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004edf1000 ioremap
0xffffb2a680006000-0xffffb2a680008000    8192 dmar_parse_one_drhd+0x1db/0x560 phys=0x00000000fed90000 ioremap
0xffffb2a680008000-0xffffb2a68000e000   24576 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea43000 ioremap
0xffffb2a68000e000-0xffffb2a680010000    8192 dmar_parse_one_drhd+0x1db/0x560 phys=0x00000000fed91000 ioremap
0xffffb2a680010000-0xffffb2a680014000   16384 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea47000 ioremap
0xffffb2a680014000-0xffffb2a680017000   12288 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea49000 ioremap
0xffffb2a680018000-0xffffb2a68001b000   12288 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea4a000 ioremap
0xffffb2a68001c000-0xffffb2a68001f000   12288 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea4b000 ioremap
0xffffb2a680020000-0xffffb2a680025000   20480 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea4c000 ioremap
0xffffb2a680025000-0xffffb2a680036000   69632 alloc_large_system_hash+0x181/0x23e pages=16 vmalloc N0=16
0xffffb2a680036000-0xffffb2a68003f000   36864 alloc_large_system_hash+0x181/0x23e pages=8 vmalloc N0=8
0xffffb2a680040000-0xffffb2a68006a000  172032 acpi_os_map_iomem+0x17c/0x1b0 phys=0x000000004ea1b000 ioremap
0xffffb2a68006a000-0xffffb2a68206b000 33558528 alloc_large_system_hash+0x181/0x23e pages=8192 vmalloc vpages N0=8192
0xffffb2a68206b000-0xffffb2a68306c000 16781312 alloc_large_system_hash+0x181/0x23e pages=4096 vmalloc vpages N0=4096
0xffffb2a68306c000-0xffffb2a6830ed000  528384 alloc_large_system_hash+0x181/0x23e pages=128 vmalloc N0=128
0xffffb2a6830ed000-0xffffb2a68316e000  528384 alloc_large_system_hash+0x181/0x23e pages=128 vmalloc N0=128
0xffffb2a68316e000-0xffffb2a683170000    8192 bpf_prog_alloc+0x3e/0xb0 pages=1 vmalloc N0=1
0xffffb2a683170000-0xffffb2a683175000   20480 _do_fork+0xcf/0x3a0 pages=4 vmalloc N0=4
... *total* 674 lines ...
0xffffffffc0c88000-0xffffffffc0cb6000  188416 load_module+0x1401/0x2c20 pages=45 vmalloc N0=45
0xffffffffc0cbe000-0xffffffffc0cc4000   24576 load_module+0x1401/0x2c20 pages=5 vmalloc N0=5
0xffffffffc0cc4000-0xffffffffc0cdd000  102400 load_module+0x1401/0x2c20 pages=24 vmalloc N0=24
0xffffffffc0ce2000-0xffffffffc0ceb000   36864 load_module+0x1401/0x2c20 pages=8 vmalloc N0=8
0xffffffffc0cef000-0xffffffffc0cfe000   61440 load_module+0x1401/0x2c20 pages=14 vmalloc N0=14
```
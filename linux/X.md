<!-- TOC -->

- [Commands](#commands)
- [Architecture](#architecture)
- [DRM](#drm)
- [Driver source](#driver-source)
- [Kernel Mode Setting (KMS)](#kernel-mode-setting-kms)
    - [Installation](#installation)
- [Direct Rendering Infrastructure (DRI)](#direct-rendering-infrastructure-dri)
- [XFree86](#xfree86)
- [Wayland](#wayland)
- [X Window System (X11 or X)](#x-window-system-x11-or-x)
    - [Releases](#releases)
        - [X11R7.6](#x11r76)
        - [X11R7.7](#x11r77)
    - [Config](#config)
    - [X.Org Server](#xorg-server)
        - [RandR ("resize and rotate")](#randr-resize-and-rotate)
    - [Additional specialized X server binaries](#additional-specialized-x-server-binaries)
- [OpenGL](#opengl)
- [X Clients](#x-clients)
    - [Window Manager](#window-manager)
- [Xsecurity](#xsecurity)
- [xhost](#xhost)
- [xauth](#xauth)
- [echo $DISPLAY](#echo-display)
- [mons - manage three monitors on X](#mons---manage-three-monitors-on-x)
- [Forwarding](#forwarding)
    - [Debug](#debug)
    - [xpra](#xpra)
- [vnc](#vnc)
- [VGA Switcheroo](#vga-switcheroo)
- [PRIME](#prime)
- [GPGPU (General-purpose computing on GPU)](#gpgpu-general-purpose-computing-on-gpu)
- [radeontop](#radeontop)

<!-- /TOC -->
# Commands
    systemctl restart display-manager # restart

# Architecture
![](https://en.wikipedia.org/wiki/File:Schema_of_the_layers_of_the_graphical_user_interface.svg)

![](https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Linux_graphics_drivers_DRI_Wayland.svg/560px-Linux_graphics_drivers_DRI_Wayland.svg.png)

# DRM
https://en.wikipedia.org/wiki/Direct_Rendering_Manager#Hardware_support

![](https://upload.wikimedia.org/wikipedia/commons/3/3d/DRM_architecture.svg)
![](https://upload.wikimedia.org/wikipedia/commons/6/62/High_level_Overview_of_DRM.svg)
![](https://upload.wikimedia.org/wikipedia/commons/6/6d/Access_to_video_card_with_DRM.svg)

radeon: until GCN 2nd gen  
amdgpu: since GCN 3rd gen, 1st gen experimental

nouveau	NVIDIA Tesla, Fermi, Kepler, Maxwell based GeForce GPUs, Tegra K1, X1 SoC  
tegra	Nvidia Tegra20, Tegra30 SoCs

bochs	Virtual VGA cards using the Bochs dispi vga interface (such as QEMU stdvga)

https://keyj.emphy.de/files/linuxgraphics_en.pdf (page 35)

https://www.kernel.org/doc/Documentation/fb/framebuffer.txt  
The frame buffer device provides an abstraction for the graphics hardware.

http://betteros.org/tut/graphics1.php  
Supposedly, fbdev is the "old" way of doing things, and KMS/DRM is the "new" way.

https://elinux.org/images/7/71/Elce11_dae.pdf  
Control all HW thru a single device node

https://events.linuxfoundation.org/sites/events/files/slides/brezillon-drm-kms.pdf  
https://01.org/linuxgraphics/gfx-docs/drm/gpu/introduction.html

    dmesg | grep modesetting
    cat /sys/class/drm/card0/device/{label,uevent}

GEM (Graphics Execution Manager): Framework for buffer management.

# Driver source
https://cgit.freedesktop.org/xorg/driver/  
https://cgit.freedesktop.org/xorg/driver/xf86-video-ati/log/

# Kernel Mode Setting (KMS)
https://wiki.archlinux.org/index.php/kernel_mode_setting  
Previously, setting up the video card was the job of the X server.  
kernel is now able to set the mode of the video card. This makes fancy graphics during bootup, virtual console and X fast switching possible, among other things.

## Installation
    Any vga= options in your bootloader as these will conflict with the native resolution enabled by KMS.
    Any video= lines that enable a framebuffer that conflicts with the driver.
    Any other framebuffer drivers (such as uvesafb)

    Intel, Nouveau, ATI and AMDGPU drivers already enable KMS automatically.
    The proprietary NVIDIA driver supports KMS (since 364.12), which has to be manually enabled.
    The proprietary AMD Catalyst driver does not support KMS

# Direct Rendering Infrastructure (DRI)
a framework for allowing direct access to graphics hardware under the X Window System in a safe, efficient way. The main use of DRI is to provide hardware acceleration for the Mesa implementation of OpenGL. DRI has also been adapted to provide OpenGL acceleration on a framebuffer console without a display server running.[citation needed]

# XFree86
version 4.8.0 released on 15 December 2008

# Wayland
![](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Wayland_display_server_protocol.svg/525px-Wayland_display_server_protocol.svg.png)  
![](https://en.wikipedia.org/wiki/File:Wayland_protocol_architecture.svg)  
a prospective replacement for X.   
It works directly with the GPU hardware, via DRI. Wayland can run an X.org server as a client, which can be rootless  
based on EGL and DRI

Ubuntu 17.10 (Artful Aardvark) ships Wayland as default  
Fedora 25+ uses Wayland for the default GNOME 3.22 desktop session  
RebeccaBlackOS: https://sourceforge.net/projects/rebeccablackos/files/

# X Window System (X11 or X)
https://en.wikipedia.org/wiki/X_Window_System  
The protocol[clarification needed] has been version 11 (hence "X11") since September 1987.  
![](https://en.wikipedia.org/wiki/File:X_client_server_example.svg)

the client and server may run on the same machine or on different ones

An X client itself may emulate an X server by providing display services to other clients. This is known as "X nesting". Open-source clients such as Xnest and Xephyr support such X nesting.

## Releases
No release plan for a X11R7.8 rollup katamari release has been proposed.  
Unlike X11R1 through X11R6.9, X11R7.x releases are not built from one monolithic source tree, but many individual modules. 

### X11R7.6
allow fragments of the X server configuration to be delivered in individual files  
running the server without a configuration file

### X11R7.7
https://www.x.org/releases/X11R7.7/doc/xorg-docs/ReleaseNotes.html  
an Open Source version of the X Window System that supports Linux, BSD, Solaris, Cygwin and MacOS X on Intel and other platforms.

Some multi-head configurations are supported in X11R7.7. Support for multiple PCI/AGP cards may require a kernel with changes to support VGA arbitration.

All users  must now set DPI or some other scaling factor explicitly

## Config
https://www.x.org/releases/X11R7.7/doc/index.html  
https://www.x.org/releases/X11R7.7/doc/man/man5/xorg.conf.5.xhtml  
https://www.x.org/releases/X11R7.7/doc/man/man4/radeon.4.xhtml

Commands: https://www.x.org/releases/X11R7.7/doc/man/man1/
Drivers: https://www.x.org/releases/X11R7.7/doc/man/man4/

## X.Org Server
https://www.x.org/releases/individual/xserver/  
implementation of the display server for the X Window System

The Xorg server relies on the operating system's native module loader support for handling program modules. The X server makes use of modules for video drivers, X server extensions, input device drivers, framebuffer layers, and internal components used by some drivers (like XAA & EXA).

    # Xorg -version
        X.Org X Server 1.19.5
        X Protocol Version 11, Revision 0

https://keyj.emphy.de/files/linuxgraphics_en.pdf  
    X Server manages input (keyboard, mouse, ...) and output (graphics only)

    The X Protocol can be extended with new functionality via Extensions. Examples:
    ◾ XSHM (»X Shared Memory«) – faster local display of bitmap graphics
    ◾ Xv (»X Video«) – hardware-accelerated video display
    ◾ GLX – OpenGL on X
    ◾ Xinerama – multi-monitor support
    ◾ XRandR (»X Resize and Rotate«) – graphics mode setting without restarting the X
    Server
    ◾ XRender – modern anti-aliased, alpha-blended 2D graphics
        ▸ today used for (almost) every 2D graphics application

### RandR ("resize and rotate")
    xrandr
        Screen 0: minimum 0 x 0, current 1234 x 823, maximum 4096 x 4096

    xrandr --output VGA1 --off  # Disabling an output

## Additional specialized X server binaries
    Xdmx
    is a proxy X server that uses one or more other X servers as its display devices. It provides multi-head X functionality for displays that might be located on different machines.

    Xnest
    is a nested X server, that operates as both an X client and X server.

    Xephyr
    is a X server that outputs to a window on a pre-existing “host” X display. Unlike Xnest which is an X proxy, and thus limited to the capabilities of the host X server, Xephyr is a full X server which uses the host X server window as a “framebuffer” via fast SHM XImages.

    Xvfb
    is a virtual framebuffer X server that can run on machines with no display hardware and no physical input devices. It emulates a dumb framebuffer using virtual memory.

    Xquartz
    is an X server that interacts with the MacOS X native Aqua window system

    Xwin
    is an X server that runs under the Cygwin environment: https://x.cygwin.com

# OpenGL
https://keyj.emphy.de/files/linuxgraphics_en.pdf

    OpenGL driver runs in userspace as part of the application process

    additional API required as »glue« to the windowing system:
    ▸ GLX for the X Window System
    ▸ WGL (Windows), AGL (Mac OS X)
    ▸ EGL for OpenGL ES (Embedded Linux, Android, iOS, ...)
        ◦ available on all systems, will eventually supersede GLX etc.

    Mesa is an open source OpenGL implementation

# X Clients
https://keyj.emphy.de/files/linuxgraphics_en.pdf

    X Clients don’t implement the X11 protocol directly, but use libraries:
    ▸ traditionally Xlib
    ▸ newer, leaner alternative: XCB (»X11 C Bindings«)
    ▸ toolkits (Motif, Gtk, Qt, ...) internally use Xlib or XCB, too

## Window Manager
special X Client that manages the positions of the top-level windows and draws window frames (»decorations«)

# Xsecurity
https://www.x.org/releases/current/doc/man/man7/Xsecurity.7.xhtml

- Host access: managed using xhost command.a single connection simultaneously.
- MIT-magic-cookie-1: without encryption.
- XDM-authorization-1: with encryption.
- sun-des-1: SunOS (and some other systems) 
- server interpreted: manipulated via xhost

 MIT-MAGIC-COOKIE-1 and XDM-AUTHORIZATION-1 store secret data in the file; so anyone who can read the file can gain access to the X server.  
 SUN-DES-1 stores only the identity of the principal who started the server (unix.hostname@domain when the server is started by xdm), and so it is not useful to anyone not authorized to connect to the server.

# xhost
    /etc/Xn.host

    family:name
    inet	Internet host (IPv4).
    inet6	Internet host (IPv6).
    dnet	DECnet host.
    nis	    Secure RPC network name.
    krb	    Kerberos V5 principal.
    local	Contains only one name, the empty string.
    si	    Server Interpreted: IPv6/hostname/localuser & localgroup

    xhost +         # allow everyone
    xhost +SI:localuser:lightdm / si:hostname:almas

# xauth
    -f authfile
        By default, XAUTHORITY environment variable or ~/.Xauthority.
    -q
        quietly.
    -v
        verbosely
    -i
        ignore any authority file locks
    -b
        attempt to break any authority file locks before proceeding
    -n
        not attempt to resolve any hostnames

    xauth info
    xauth list

# echo $DISPLAY
    [host]:display#.screen#

# mons - manage three monitors on X
    git clone --recursive https://github.com/Ventto/mons.git
    cd mons
    sudo make install

# Forwarding
https://wiki.archlinux.org/index.php/Secure_Shell#X11_forwarding

    AllowTcpForwarding yes
    X11Forwarding yes
    X11DisplayOffset 10
    X11UseLocalhost yes

    export XAUTHORITY=~fzinfz/.Xauthority
    xauth add $(xauth -f ~fzinfz/.Xauthority list|tail -1)

## Debug
https://stackoverflow.com/questions/28392949

    ss -anp | grep 6010     # 127.0.0.1:6010 (= 6000+10 for localhost:10.0)
    tcpdump -nS -i any port 6010

## xpra 
re-attachable: http://xpra.org/

    apt install -y xpra         # remote
    xpra start :13              # remote
    xpra attach ssh:remote:13   # local
    DISPLAY=:13 xeyes           # remote

https://github.com/Xpra-org/xpra/blob/master/docs/Usage/README.md

https://wiki.archlinux.org/title/Xpra



# vnc

    vncserver -kill :1

# VGA Switcheroo
https://01.org/linuxgraphics/gfx-docs/drm/gpu/vga-switcheroo.html

Linux subsystem for laptop hybrid graphics. 2 flavors:
- muxed: both GPUs can drive all displays
- muxless: only one connected to outputs. The other one is merely used to offload rendering, its results are copied over PCIe into the framebuffer. On Linux this is supported with DRI PRIME.

# PRIME
https://wiki.archlinux.org/index.php/PRIME

PRIME is a technology used to manage hybrid graphics found on recent laptops (Optimus for NVIDIA, AMD Dynamic Switchable Graphics for Radeon). PRIME GPU offloading and Reverse PRIME is an attempt to support muxless hybrid graphics in the Linux kernel.

    xrandr --listproviders  # check support
    xrandr --setprovideroffloadsink 1 0
    xrandr --setprovideroffloadsink radeon Intel
    DRI_PRIME=1 glxinfo | grep "OpenGL renderer"

    # Discrete card as primary GPU, XRandR 1.4+
    xrandr --setprovideroutputsource Intel nouveau

        dedicated GPU’s output is copied over to the integrated GPU
        ◦ not saving power (quite the contrary – both GPUs are active!)

https://devtalk.nvidia.com/default/topic/957814/prime-and-prime-synchronization/  
https://negativo17.org/complex-setup-with-nvidia-optimus-nouveau-prime-on-fedora-20/

# GPGPU (General-purpose computing on GPU)
https://wiki.archlinux.org/index.php/GPGPU

# radeontop
    make amdgpu=1   # show VRAM usage. requires libdrm >= 2.4.63

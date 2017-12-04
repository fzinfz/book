<!-- TOC -->

- [Architecture](#architecture)
- [DRM](#drm)
- [XFree86](#xfree86)
- [X Window System (X11 or X)](#x-window-system-x11-or-x)
    - [Releases](#releases)
        - [X11R7.6](#x11r76)
        - [X11R7.7](#x11r77)
    - [Config](#config)
    - [X.Org Server](#xorg-server)
        - [RandR ("resize and rotate")](#randr-resize-and-rotate)
    - [Additional specialized X server binaries](#additional-specialized-x-server-binaries)
- [Xsecurity](#xsecurity)
- [xhost](#xhost)
- [xauth](#xauth)
- [echo $DISPLAY](#echo-display)
- [mons - manage three monitors on X](#mons---manage-three-monitors-on-x)
- [Forwarding](#forwarding)
- [vnc](#vnc)
- [Wayland](#wayland)

<!-- /TOC -->

# Architecture
![](https://en.wikipedia.org/wiki/File:Schema_of_the_layers_of_the_graphical_user_interface.svg)

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

# XFree86
version 4.8.0 released on 15 December 2008

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

### RandR ("resize and rotate")
communications protocol written as an extension to the X11 protocol.   
An implementation of RandR is part of the X.Org Server.

resize, rotate and reflect the root window of a screen.   
setting the screen refresh rate.

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

# vnc
    vncserver -kill :1

# Wayland
![](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Wayland_display_server_protocol.svg/525px-Wayland_display_server_protocol.svg.png)  
![](https://en.wikipedia.org/wiki/File:Wayland_protocol_architecture.svg)  
a prospective replacement for X.   
It works directly with the GPU hardware, via DRI. Wayland can run an X.org server as a client, which can be rootless

Ubuntu 17.10 (Artful Aardvark) ships Wayland as default  
Fedora 25+ uses Wayland for the default GNOME 3.22 desktop session  
https://sourceforge.net/projects/rebeccablackos/files/
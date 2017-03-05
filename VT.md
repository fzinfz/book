<!-- TOC -->

- [ESXi](#esxi)
    - [vmdk](#vmdk)

<!-- /TOC -->

# ESXi
## vmdk
```
vmkfstools -i "source.vmdk" -d thin "destination.vmdk"
```
The tool also reverts a vmdk which was blown up, back into a thin file! ([Ref](http://www.how2blog.de/?p=98))


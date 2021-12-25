<!-- TOC -->

- [ANDROID](#android)
    - [Automation](#automation)
        - [selendroid - JAVA](#selendroid---java)
        - [appium - nodejs](#appium---nodejs)
    - [adb](#adb)
        - [Data Transfer](#data-transfer)
        - [Debug](#debug)
    - [fastboot](#fastboot)
        - [twrp](#twrp)
        - [miflash unlock](#miflash-unlock)
- [IOS](#ios)
    - [Automation](#automation-1)
    - [Bar/QR code to REST API](#barqr-code-to-rest-api)
- [Google Authenticator](#google-authenticator)

<!-- /TOC -->

# ANDROID
## Automation
### selendroid - JAVA
http://selendroid.io/

### appium - nodejs
http://appium.io/  
https://github.com/appium/sample-code/tree/master/sample-code/examples

## adb
### Data Transfer

    adb devices
    adb ls /sdcard
    adb push foo.zip /sdcard/Download/

### Debug
https://developer.android.com/studio/command-line/dumpsys.html#meminfo

    adb shell dumpsys meminfo # http://i.imgur.com/DKsJ1Cb.png
    adb shell getprop ro.build.ab_update # check if dual boot partition

## fastboot
### twrp
https://miuiver.com/how-to-flash-twrp/

    apt install fastboot
    fastboot devices
    fastboot flash recovery twrp.img
    fastboot reboot # hold [Vol-Up]

### miflash unlock
Down+Power: 

    fastboot oem edl
    fastboot oem edl-reboot

Clear partions & /data: https://zhuanlan.zhihu.com/p/413293727  
ROMs: https://xiaomirom.com/series/   
Fix boot hang: https://topjohnwu.github.io/Magisk/install.html  # .apk->.zip; twrp->install 

# IOS
## Automation
see `appium` above

## Bar/QR code to REST API
https://workflow.is/docs/taking-advantage-of-web-apis    

# Google Authenticator
on multiple devices: delete old config and scan new qr code at the same time

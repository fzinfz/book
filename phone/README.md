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
  - [Mi](#mi)
    - [miflash unlock](#miflash-unlock)
  - [SSH Button](#ssh-button)
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
    adb push foo.zip /sdcard/Download/        # file
    adb push . /sdcard/Download/NewFolder     # folder
    adb pull -a /file_on_phone # -a: preserve file timestamp and mode

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

## Mi
### miflash unlock
http://www.miui.com/unlock/index.html

    设置——更多设置——开发者选项——设备解锁状态

Down+Power: 

    fastboot oem edl
    fastboot oem edl-reboot

Clear partions & /data: https://zhuanlan.zhihu.com/p/413293727  
ROMs: https://xiaomirom.com/series/   
Fix boot hang: https://topjohnwu.github.io/Magisk/install.html  # .apk->.zip; twrp->install 

## SSH Button
|Features|key|Lack|Lang|Link|
|---|---|---|---|---|
|WOL|-|?|ReactNative|https://github.com/BootBoi/android-app|
|-|custom|output|-|https://play.google.com/store/apps/details?id=com.pd7l.sshbutton|
|.json|app|?|JAVA|https://github.com/Skarafaz/mercury|


# IOS
## Automation
https://appium.io/docs/en/drivers/ios-xcuitest/index.html

## Bar/QR code to REST API
https://workflow.is/docs/taking-advantage-of-web-apis    

# Google Authenticator
on multiple devices: delete old config and scan new qr code at the same time

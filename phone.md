<!-- TOC -->

- [ANDROID](#android)
    - [Automation](#automation)
        - [selendroid - JAVA](#selendroid---java)
        - [appium - nodejs](#appium---nodejs)
    - [Data transfer](#data-transfer)
    - [Debug](#debug)
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

## Data transfer
    adb push filename /sdcard/.

## Debug
https://developer.android.com/studio/command-line/dumpsys.html#meminfo

    adb shell dumpsys meminfo

![](http://i.imgur.com/DKsJ1Cb.png)

## miflash unlock
    fastboot oem edl
    fastboot oem edl-reboot

# IOS
## Automation
see `appium` above

## Bar/QR code to REST API
https://workflow.is/docs/taking-advantage-of-web-apis    

# Google Authenticator
on multiple devices: delete old config and scan new qr code at the same time

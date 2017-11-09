<!-- TOC -->

- [ANDROID](#android)
    - [Data transfer](#data-transfer)
    - [Debug](#debug)
    - [miflash unlock](#miflash-unlock)
- [IOS](#ios)
    - [Bar/QR code to REST API](#barqr-code-to-rest-api)

<!-- /TOC -->

# ANDROID
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
## Bar/QR code to REST API
https://workflow.is/docs/taking-advantage-of-web-apis    
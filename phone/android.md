<!-- TOC -->

- [adb](#adb)
    - [Wifi](#wifi)
    - [devices](#devices)
    - [Data Transfer](#data-transfer)
    - [Debug](#debug)
- [fastboot](#fastboot)
    - [twrp](#twrp)
- [Apps](#apps)
    - [SSH Button](#ssh-button)
- [Automation](#automation)
    - [selendroid - JAVA](#selendroid---java)
    - [appium - nodejs](#appium---nodejs)

<!-- /TOC -->

# adb

    adb version

## Wifi
Ver | Link | Prepare | CMD
-- | -- | -- | --
Android 11 (API level 30)+ | https://developer.android.com/tools/adb#wireless-android11-command-line | MIUI: 设置前关悬浮球 | adb pair IP:PORT_Dynamic && adb connect IP:PORT
Android 10 (API level 29)- | https://developer.android.com/tools/adb#wireless | USB：adb tcpip 5555 && Disconnect | adb connect IP:5555

## devices

    adb devices
    adb -s 192.168.88.39:42745 ls /  # `-s` if more than one device/emulator 

    global options:
    -e                       use TCP/IP device (error if multiple TCP/IP devices available)
    -s SERIAL                use device with given serial (overrides $ANDROID_SERIAL)
    -t ID                    use device with given transport id
    
## Data Transfer

    adb shell ls -hs /sdcard

    # Download
    adb pull -a /file_on_phone # -a: preserve file timestamp and mode
    adb shell ls /sdcard/DCIM/Screenshots/* | %{ adb pull -a $_} # powershell , w/ speed
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8    # powershell pipe中文乱码fix

    # Delete
    Get-ChildItem -Path . –File | %{ adb -s 192.168.7.126:38855 shell "ls -l /sdcard/DCIM/Screenshots/$_" } 

    # Upload
    adb push foo.zip /sdcard/Download/        # file
    adb push . /sdcard/Download/NewFolder     # folder

## Debug
https://developer.android.com/studio/command-line/dumpsys.html#meminfo

    adb shell dumpsys meminfo # http://i.imgur.com/DKsJ1Cb.png
    adb shell getprop ro.build.ab_update # check if dual boot partition

# fastboot
## twrp
https://miuiver.com/how-to-flash-twrp/

    apt install fastboot
    fastboot devices
    fastboot flash recovery twrp.img
    fastboot reboot # hold [Vol-Up]

# Apps
## SSH Button
|Features|key|Lack|Lang|Link|
|---|---|---|---|---|
|WOL|-|?|ReactNative|https://github.com/BootBoi/android-app|
|-|custom|output|-|https://play.google.com/store/apps/details?id=com.pd7l.sshbutton|
|.json|app|?|JAVA|https://github.com/Skarafaz/mercury|

# Automation
## selendroid - JAVA
http://selendroid.io/

## appium - nodejs
http://appium.io/  
https://github.com/appium/sample-code/tree/master/sample-code/examples
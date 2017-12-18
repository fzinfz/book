<!-- TOC -->

- [pip](#pip)
    - [Proxy](#proxy)
    - [Installing from local](#installing-from-local)
- [VSCode](#vscode)
    - [Remote debugging](#remote-debugging)
- [Pythonista on IOS](#pythonista-on-ios)
- [Text To Speech](#text-to-speech)
    - [Offline](#offline)
    - [IBM](#ibm)
    - [Google](#google)
    - [AWS](#aws)
    - [Bing](#bing)
    - [Xunfei](#xunfei)
    - [Tencent](#tencent)
    - [Baidu - Free for Online](#baidu---free-for-online)
- [Speech recognition](#speech-recognition)

<!-- /TOC -->

# pip
## Proxy
    export all_proxy="socks5://x:y" # cause python error: Missing dependencies for SOCKS support.
    pip install --proxy=https://user@mydomain:port  somepackage

## Installing from local
    pip install --download DIR -r requirements.txt
    pip wheel --wheel-dir DIR -r requirements.txt
    pip install --no-index --find-links=DIR -r requirements.txt

# VSCode
## Remote debugging
VS: https://youtu.be/y1Qq7BrV6Cc?t=228  
VSCode: https://code.visualstudio.com/docs/python/debugging#_remote-debugging  

    # bug: https://github.com/DonJayamanne/pythonVSCode/issues/981#issuecomment-308085243
    pip install ptvsd==3.0.0    

```python
import ptvsd
ptvsd.enable_attach("my_secret", address = ('0.0.0.0', 3000))

ptvsd.wait_for_attach()
```

# Pythonista on IOS
https://github.com/Pythonista-Tools/Pythonista-Tools/blob/master/Utilities.md

# Text To Speech
## Offline
https://pyttsx3.readthedocs.io/en/latest/  (no file saving?)

    SAPI5 on Windows XP and Windows Vista and Windows 8,8.1 , 10
    NSSpeechSynthesizer on Mac OS X 10.5 (Leopard) and 10.6 (Snow Leopard)
    espeak on Ubuntu Desktop Edition 8.10 (Intrepid), 9.04 (Jaunty), and 9.10 (Karmic)

http://espeak.sourceforge.net/commands.html

    espeak "unnatural man voice"  -w out.wav  # apt install -y libespeak1
    setup_espeak.exe #  SAPI5 version

Swift: https://youtu.be/bl6hEBXuv5Y?t=1057

## IBM
https://console.bluemix.net/catalog/services/text-to-speech

Free: 10,000 characters per month.  deleted after 30 days of inactivity.  
Paid: $0.02 USD/THOUSAND CHAR

https://github.com/watson-developer-cloud/python-sdk

## Google
https://github.com/pndurette/gTTS

    gtts-cli -f hello.txt -l 'cs' -o hello.mp3

    from gtts import gTTS
    tts = gTTS(text='Hello', lang='en', slow=True)
    tts.save("hello.mp3")

## AWS
https://aws.amazon.com/polly/pricing/

free: 5 million characters/m/first 12m  
$4.00 per 1 million characters

## Bing
https://azure.microsoft.com/en-us/services/cognitive-services/speech/  
https://azure.microsoft.com/en-us/pricing/details/cognitive-services/speech-api/

|TIER|FEATURES|UNIT|PRICE|
|---|---|---|---|
|Bing Speech API—free||Transactions|5,000 transactions free per month|
|Bing Speech-to-Text API|Utterances up to 15 seconds long|Transactions|$4 per 1,000 transactions|
|Bing Text-to-Speech API||Transactions|$4 per 1,000 transactions|

https://github.com/westparkcom/Python-Bing-TTS

## Xunfei
http://www.xfyun.cn/services/offline_tts (99+ RMB/m)

## Tencent
https://cloud.tencent.com/product/aai (Price unknown)

## Baidu - Free for Online
http://yuyin.baidu.com/#try  
http://yuyin.baidu.com/docs/tts/136

# Speech recognition
https://github.com/Uberi/speech_recognition
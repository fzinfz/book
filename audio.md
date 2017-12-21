<!-- TOC -->

- [Software](#software)
- [Text To Speech](#text-to-speech)
    - [Offline](#offline)
    - [Google](#google)
    - [AWS](#aws)
    - [IBM](#ibm)
    - [Bing](#bing)
    - [Baidu - Free for Online](#baidu---free-for-online)
    - [Xunfei](#xunfei)
    - [Tencent](#tencent)
- [Speech recognition](#speech-recognition)

<!-- /TOC -->

# Software
https://en.wikipedia.org/wiki/Comparison_of_digital_audio_editors  
https://en.wikipedia.org/wiki/Comparison_of_free_software_for_audio

# Text To Speech
My rate: Google > Microsoft Zira Desktop ~ AWS Justin >> IBM/Baidu >> Bing/espeak

## Offline
https://en.wikipedia.org/wiki/Comparison_of_speech_synthesizers

https://pyttsx3.readthedocs.io/en/latest/  (no file saving?)

    SAPI5 on Windows XP and Windows Vista and Windows 8,8.1 , 10
    NSSpeechSynthesizer on Mac OS X 10.5 (Leopard) and 10.6 (Snow Leopard)
    espeak on Ubuntu Desktop Edition 8.10 (Intrepid), 9.04 (Jaunty), and 9.10 (Karmic)

http://espeak.sourceforge.net/commands.html

    espeak "unnatural man voice"  -w out.wav  # apt install -y libespeak1
    setup_espeak.exe #  SAPI5 version

Swift: https://youtu.be/bl6hEBXuv5Y?t=1057

## Google
https://play.google.com/store/apps/details?id=com.google.android.tts

https://github.com/pndurette/gTTS

    gtts-cli -f hello.txt -l 'cs' -o hello.mp3

    from gtts import gTTS
    tts = gTTS(text='Hello', lang='en', slow=True)
    tts.save("hello.mp3")

## AWS
https://console.aws.amazon.com/polly  
https://aws.amazon.com/polly/pricing/

free: 5 million characters/m/first 12m  
$4.00 per 1 million characters

## IBM
https://text-to-speech-demo.ng.bluemix.net  
https://console.bluemix.net/catalog/services/text-to-speech

Free: 10,000 characters per month.  deleted after 30 days of inactivity.  
Paid: $0.02 USD/THOUSAND CHAR

https://github.com/watson-developer-cloud/python-sdk

## Bing
https://azure.microsoft.com/en-us/services/cognitive-services/speech/  
https://azure.microsoft.com/en-us/pricing/details/cognitive-services/speech-api/

|TIER|FEATURES|UNIT|PRICE|
|---|---|---|---|
|Bing Speech API—free||Transactions|5,000 transactions free per month|
|Bing Speech-to-Text API|Utterances up to 15 seconds long|Transactions|$4 per 1,000 transactions|
|Bing Text-to-Speech API||Transactions|$4 per 1,000 transactions|

https://github.com/westparkcom/Python-Bing-TTS

## Baidu - Free for Online
http://yuyin.baidu.com/#try  
http://yuyin.baidu.com/docs/tts/136

## Xunfei
http://www.xfyun.cn/services/offline_tts (99+ RMB/m)

## Tencent
https://cloud.tencent.com/product/aai (Price unknown)

# Speech recognition
https://github.com/Uberi/speech_recognition
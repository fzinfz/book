<!-- TOC -->

- [Software](#software)
- [Text To Speech](#text-to-speech)
    - [Microsoft](#microsoft)
    - [Bing](#bing)
    - [Ali](#ali)
    - [Google](#google)
    - [AWS](#aws)
    - [IBM](#ibm)
    - [Xunfei](#xunfei)
    - [Tencent](#tencent)
    - [Baidu](#baidu)
    - [Offline](#offline)
- [Speech recognition](#speech-recognition)
    - [Chinese](#chinese)
    - [Azure](#azure)

<!-- /TOC -->

# Software
https://en.wikipedia.org/wiki/Comparison_of_digital_audio_editors  
https://en.wikipedia.org/wiki/Comparison_of_free_software_for_audio  

# Text To Speech
My rate: Microsoft Neural > Google > Microsoft Zira Desktop ~ AWS Justin >> IBM/Baidu >> espeak
   
## Microsoft
Demo: https://speech.microsoft.com/customvoice  

https://azure.microsoft.com/en-us/pricing/details/cognitive-services/speech-services/

    STT - 5 audio hours free per month
    TTS Standard - 5M characters free per month
    TTS Neural   - 0.5M characters free per month

Portal: https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.CognitiveServices%2Faccounts

SDK/REST support: https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/overview

https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/rest-text-to-speech

Python SDK: https://github.com/Azure-Samples/cognitive-services-speech-sdk/blob/master/quickstart/python/text-to-speech/quickstart.ipynb  
Console: https://github.com/Azure-Samples/cognitive-services-speech-sdk/tree/master/samples/python/console  
Flask app: https://github.com/MicrosoftTranslator/Text-Translation-API-V3-Flask-App-Tutorial

## Bing
https://azure.microsoft.com/en-us/services/cognitive-services/speech/  
https://azure.microsoft.com/en-us/pricing/details/cognitive-services/speech-api/

|TIER|FEATURES|UNIT|PRICE|
|---|---|---|---|
|Bing Speech API—free||Transactions|5,000 transactions free per month|
|Bing Speech-to-Text API|Utterances up to 15 seconds long|Transactions|$4 per 1,000 transactions|
|Bing Text-to-Speech API||Transactions|$4 per 1,000 transactions|

https://github.com/westparkcom/Python-Bing-TTS

## Ali
Demo: https://ai.aliyun.com/nls/tts  
Non-free: https://help.aliyun.com/document_detail/84881.html#h1-u8BA1u8D39u65B9u5F0Fu548Cu62A5u4EF73

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

## Xunfei
http://www.xfyun.cn/services/offline_tts (99+ RMB/m)

## Tencent
https://cloud.tencent.com/product/aai (Price unknown)

## Baidu
https://developer.baidu.com/vcast  

http://yuyin.baidu.com/#try  
http://yuyin.baidu.com/docs/tts/136

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

# Speech recognition
https://github.com/Uberi/speech_recognition

## Chinese
https://www.zhihu.com/question/28167247 

## Azure
https://azure.microsoft.com/en-us/pricing/details/cognitive-services/speech-services/

    5 audio hours free per month
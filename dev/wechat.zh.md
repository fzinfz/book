
# Token
https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET

# IP List
https://api.weixin.qq.com/cgi-bin/getcallbackip?access_token=ACCESS_TOKEN

    [print("add address=" + i.replace("\\","") + " list=wechat")  for i in list ]   # ip list rule
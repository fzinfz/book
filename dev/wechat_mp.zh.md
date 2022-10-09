
<!-- TOC -->

- [Docs](#docs)
- [DevTool](#devtool)
- [生命周期](#生命周期)
  - [app](#app)
  - [pages](#pages)
- [逻辑](#逻辑)
  - [app.js *](#appjs-)
  - [page.js *](#pagejs-)
- [配置](#配置)
  - [app.json *](#appjson-)
  - [page.json](#pagejson)
- [样式 - WeiXin Style Sheets](#样式---weixin-style-sheets)
  - [同层渲染](#同层渲染)
  - [app.wxss](#appwxss)
  - [page.wxss](#pagewxss)
- [结构](#结构)
  - [page.wxml *](#pagewxml-)
    - [wxs - WeiXin Script](#wxs---weixin-script)
    - [简易双向绑定](#简易双向绑定)
    - [navigator](#navigator)
- [Map](#map)
  - [jssdk](#jssdk)
  - [plugin](#plugin)
- [Code](#code)
- [Books](#books)

<!-- /TOC -->

# Docs
开始：https://developers.weixin.qq.com/miniprogram/dev/framework/quickstart/getstart.html  
小程序专用邮箱登录：https://mp.weixin.qq.com/  
app&pages: https://developers.weixin.qq.com/miniprogram/dev/framework/structure.html

|作用|格式|App|Page|
|---|---|---|---|
|逻辑|js|必需|必需|
|配置|json|必需|-|
|样式表|wxss|-|-|
|结构|wxml|无|必需|

# DevTool
https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html  
推送到微信：右上角 =》 详情-本地设置

# 生命周期
## app
https://developers.weixin.qq.com/miniprogram/dev/framework/runtime/operating-mechanism.html

https://developers.weixin.qq.com/miniprogram/dev/reference/api/App.html

    onLaunch(Object object) 小程序初始化完成时触发，全局只触发一次。
    onShow(o)/Hide()/Error(String error)/PageNotFound(o)/UnhandledRejection(o)/ThemeChange(o)/CUSTOM

## pages
https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page-life-cycle.html  
onLaunch/Show/... 同app： https://developers.weixin.qq.com/miniprogram/dev/reference/api/App.html

# 逻辑
## app.js *
https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/app.html

    App({ // App() 必须在 app.js 中调用，必须调用且只能调用一次。
        globalData: 'I am global data'
    })

    // page.js
    const appInstance = getApp() // 获取到全局唯一的 App 实例
    console.log(appInstance.globalData) // I am global data

## page.js *
https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html  
https://developers.weixin.qq.com/miniprogram/dev/reference/api/Page.html

    data/options/behaviors/onXXX/CUSTOM
    开发者可以添加任意的函数或数据到 Object 参数中，在页面的函数中用 this 可以访问。这部分属性会在页面实例创建时进行一次深拷贝。
    
    Page({
    data: {
        message: 'Hello MINA!'
        array: [1, 2, 3, 4, 5]
        view: 'MINA'
        staffA: {firstName: 'Hulk', lastName: 'Hu'},
    }
    })

# 配置
## app.json *
https://developers.weixin.qq.com/miniprogram/dev/framework/config.html  
Layout: https://res.wx.qq.com/wxdoc/dist/assets/img/config.344358b1.jpg

|app.json|类型|必填|描述|
|---|---|---|---|
|pages|String Array|是|设置页面路径|
|window|Object|否|设置默认页面的窗口表现|
|tabBar|Object|否|设置底部 tab 的表现|
|networkTimeout|Object|否|设置网络超时时间|
|debug|Boolean|否|设置是否开启 debug 模式|

## page.json
https://developers.weixin.qq.com/miniprogram/dev/framework/config.html#%E9%A1%B5%E9%9D%A2%E9%85%8D%E7%BD%AE

# 样式 - WeiXin Style Sheets
## 同层渲染
https://developers.weixin.qq.com/community/develop/article/doc/000c4e433707c072c1793e56f5c813

## app.wxss
https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxss.html

    @import "common.wxss";  /** app.wxss **/

    <view class="normal_view" />
    <view style="color:{{color}};" />

## page.wxss
https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxss.html

# 结构
## page.wxml *
https://developers.weixin.qq.com/miniprogram/dev/reference/wxml/

    # get value from: page.js - Page({ data: { } })
    <view> {{message}} </view>

    <view wx:for="{{array}}"> {{item}} </view>

    <view wx:if="{{view == 'WEBVIEW'}}"> WEBVIEW </view>
    <view wx:elif="{{view == 'APP'}}"> APP </view>
    <view wx:else="{{view == 'MINA'}}"> MINA </view>

    <template name="staffName">
    <template is="staffName" data="{{...staffA}}"></template>

### wxs - WeiXin Script

    <wxs module="m1">
    var msg = "hello world";
    module.exports.message = msg;
    </wxs>

    <view> {{m1.message}} </view>

### 简易双向绑定
https://developers.weixin.qq.com/miniprogram/dev/framework/view/two-way-bindings.html

    <input value="{{value}}" />        单向
    <input model:value="{{value}}" />  双向

### navigator
https://mp.weixin.qq.com/debug/wxadoc/dev/component/navigator.html


# Map
Demo: https://github.com/TencentLBS/TencentMapMiniProgramDemo  

Doc: https://mp.weixin.qq.com/debug/wxadoc/dev/component/map.html#map  
controls控件即将废弃 => view

## jssdk
https://lbs.qq.com/miniProgram/jsSdk/jsSdkGuide/jsSdkOverview  
http://lbs.qq.com/qqmap_wx_jssdk/index.html  

个性化地图：https://lbs.qq.com/dev/console/custom/guide#miniapp

## plugin
https://lbs.qq.com/miniProgram/plugin/pluginGuide/pluginStart

# Code
```
  <view class="section">
    <view class="flex-wrp" style="flex-direction:row;">
      <view class="flex-item">
        <button bindtap='search'>Search</button>
      </view>
      <view class="flex-item">
        <button bindtap='clear'>Clear</button>
      </view>
    </view>
  </view>
  
  .flex-wrp{display:flex;}

button {
  margin: 0.5rem
}

<input value="{{ addr }}" bindinput='inputAddr'></input>

input {
  border-radius:4px;
  border-color: blue;
  border-style: solid;
  padding: 0.5rem;
  width: 90%
}

inputAddr: function (e) {
this.setData({
    addr: e.detail.value,
})
},

  clear: function () {
    this.setData({
      addr: ""
    });
  },

  data: {
    markers: [{
      id: 0,
    }]
  },

    <radio-group class="radio-group" bindchange="radioChange">
      <label class="radio" wx:for="{{items}}" wx:key="city" >
        <radio value="{{item.city}}站" checked="{{item.checked}}" bindtap='search' />{{item.city}}
      </label>
    </radio-group>

    items: [
      { city: '深圳' },
      { city: '广州' },
    ]

  radioChange: function (e) {
    this.setData({
      addr: e.detail.value
    });
  },

var QQMapWX = require('../../libs/qqmap-wx-jssdk.js');
var qqmapsdk;

  search: function (e) {
    var that = this;
    var addr_array;
    if (typeof e === "undefined") {
      addr_array = that.data.region;
    } else {
      addr_array = e.detail.value;
    };
    qqmapsdk.geocoder({
      address: addr_array.join(''),
      success: function (res) {
        that.setData({
          region: addr_array,
          region_hint: addr_array[1],
          //raw: JSON.stringify(res, null, '\t'),
          location: JSON.stringify(res.result.location),
          lng: res.result.location.lng,
          lat: res.result.location.lat,
        });
      }
    });
  },

    wx.getSystemInfo({
      success: function (res) {
        _this.setData({
          view: {
            Height: res.windowHeight - 20
          }
        })
      }
    });
```

# Books
http://www.weixinbook.net/download/


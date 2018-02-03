
<!-- TOC -->

- [文件结构](#文件结构)
- [Map](#map)
- [Code](#code)

<!-- /TOC -->

# 文件结构
https://mp.weixin.qq.com/debug/wxadoc/dev/framework/structure.html

|文件类型|必填|作用|
|---|---|---|
|js|是|页面逻辑|
|wxml|是|页面结构|
|wxss|否|页面样式表|
|json|否|页面配置|

|文件|必填|作用|
|---|---|---|
|app.js|是|小程序逻辑|
|app.json|是|小程序公共设置|
|app.wxss|否|小程序公共样式表|

https://mp.weixin.qq.com/debug/wxadoc/dev/framework/config.html

|app.json|类型|必填|描述|
|---|---|---|---|
|pages|String Array|是|设置页面路径|
|window|Object|否|设置默认页面的窗口表现|
|tabBar|Object|否|设置底部 tab 的表现|
|networkTimeout|Object|否|设置网络超时时间|
|debug|Boolean|否|设置是否开启 debug 模式|

# Map
https://mp.weixin.qq.com/debug/wxadoc/dev/component/map.html#map

http://lbs.qq.com/qqmap_wx_jssdk/index.html

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
```

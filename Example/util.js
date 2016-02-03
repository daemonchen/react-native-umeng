var React = require('react-native')

var {
    NativeModules
} = React

var UMengManager = NativeModules.UMengManager;

module.exports = {
    wechatSessionShare: function(data, callback){//分享到微信
        UMengManager.wechatSessionShare(data, callback);
    },
    presentSnsIconSheetView: function(data, callback){//默认分享，包括微信，微博，短信，邮箱
        UMengManager.presentSnsIconSheetView(data, callback);
    },
    logPage: function(page){//记录页面加载
        UMengManager.logPage(page);
    },
    endLogPageView: function(page){//记录页面退出
        UMengManager.endLogPageView(page);
    },
    logEvent: function(event, data){//记录事件
        UMengManager.logEvent(event, data);
    }
};

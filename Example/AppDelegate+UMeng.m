//
//  AppDelegate+UMeng.m
//  awesomeMobile
//
//  Created by 陈光远 on 16/1/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "AppDelegate+UMeng.h"

#import "UMSocialWechatHandler.h"
#import "MobClick.h"


@implementation AppDelegate (UMeng)

- (void)registerUMeng
{
  //设置友盟社会化组件appkey
  [UMSocialData setAppKey:UmengAppkey];

  //打开调试log的开关
//  [UMSocialData openLog:YES];

  //设置微信AppId，设置分享url，默认使用友盟的网址
  [UMSocialWechatHandler setWXAppId:@"your wexin apid" appSecret:@"your weixin app secret key" url:@"url stuff"];


//  对未安装客户端平台进行隐藏
   [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline]];

  //使用友盟统计
  [MobClick startWithAppkey:UmengAppkey reportPolicy:BATCH   channelId:nil];

  NSLog(@"-------registerUMeng");
}


@end

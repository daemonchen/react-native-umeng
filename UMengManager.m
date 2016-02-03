//
//  UMengManager.m
//  awesomeMobile
//
//  Created by 陈光远 on 16/1/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UMengManager.h"

#import "RCTBridge.h"
#import "RCTUtils.h"

@implementation UMengManager

@synthesize bridge = _bridge;

-(void)shareToSns:(NSDictionary *)aData callback:(RCTResponseSenderBlock)callback{
  self.callback = callback;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    //设置分享的点击链接
    [UMSocialData defaultData].extConfig.wechatSessionData.url = aData[@"url"];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =aData[@"url"];
//    [UMSocialData defaultData].extConfig.sinaData.url = aData[@"url"];
    //设置分享图片
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:aData[@"image"]];
//    设置微信好友title
    [UMSocialData defaultData].extConfig.wechatSessionData.title = aData[@"title"];
//    设置微信朋友圈title
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = aData[@"title"];
    UIViewController *vc = RCTKeyWindow().rootViewController;
    [UMSocialSnsService presentSnsIconSheetView:vc
                                         appKey:UmengAppkey
                                      shareText:aData[@"text"]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms,
                                                 UMShareToEmail,UMShareToSina,nil]
                                       delegate:self];
  });
  
}

//实现回调方法（可选）:
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
  //根据`responseCode`得到发送结果,如果分享成功
  if(response.responseCode == UMSResponseCodeSuccess)
  {
    //得到分享到的微博平台名
    self.callback(@[response.data]);
//    NSLog(@"-------share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
  }
}


-(void)postSNSWithTypes:(NSArray *)type params:(NSDictionary *)params callback:(RCTResponseSenderBlock)callback
{
  UIViewController *vc = RCTKeyWindow().rootViewController;
//  设置分享图片
  UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                      params[@"image"]];
  [[UMSocialDataService defaultDataService]  postSNSWithTypes:type
                                                      content:params[@"text"]
                                                        image:nil
                                                     location:nil
                                                  urlResource:urlResource
                                          presentedController:vc
                                                   completion:^(UMSocialResponseEntity *response){
                                                     if (response.responseCode == UMSResponseCodeSuccess) {
                                                       NSLog(@"分享成功！");
                                                       callback(@[response.data]);
                                                     }
                                                   }];
}
RCT_EXPORT_MODULE();

//调用umeng默认的分享
RCT_EXPORT_METHOD(presentSnsIconSheetView:(NSDictionary *)data callback:(RCTResponseSenderBlock) callback)
{

  [self shareToSns:data callback:callback];
  
}

//直接调用微信好友分享
RCT_EXPORT_METHOD(wechatSessionShare:(NSDictionary *)data callback:(RCTResponseSenderBlock) callback)
{
//  data.type = UMShareToWechatSession;
  [self postSNSWithTypes:@[UMShareToWechatSession] params:data callback:callback];
}

//记录页面加载
RCT_EXPORT_METHOD(logPage:(NSString *) page)
{
  [MobClick beginLogPageView:page];//("page"为页面名称)
}

//记录页面退出
RCT_EXPORT_METHOD(endLogPageView:(NSString *) page)
{
  [MobClick endLogPageView:page];//("page"为页面名称)
}

//记录事件
RCT_EXPORT_METHOD(logEvent:(NSString *)eventId attributes:(NSDictionary *)attributes)
{
  [MobClick event:(NSString *)eventId attributes:(NSDictionary *)attributes];
}
@end
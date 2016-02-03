//
//  UMengManager.h
//  awesomeMobile
//
//  Created by 陈光远 on 16/1/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#ifndef UMengManager_h
#define UMengManager_h

#import "RCTBridgeModule.h"
#import "UMSocial.h"
#import "MobClick.h"
#define UmengAppkey @"UmengAppkey"

@interface UMengManager : NSObject <RCTBridgeModule, UMSocialUIDelegate>
@property (nonatomic, strong) RCTResponseSenderBlock callback;
-(void) shareToSns:(NSDictionary *)aData callback:(RCTResponseSenderBlock)callback;
-(void) postSNSWithTypes:(NSArray *) type params:(NSDictionary *)params callback:(RCTResponseSenderBlock)callback;
@end

#endif /* UMengManager_h */

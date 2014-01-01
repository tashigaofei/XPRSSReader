//
//  XPAPIEngine.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "MKNetworkKit.h"

@interface XPAPIEngine : MKNetworkEngine

+ (XPAPIEngine *) sharedInstance;

@end

#import "XPSubscription.h"
#import "XPFeed.h"
#import "XPOldReaderUser.h"
#import "XPNetworkOperation.h"

#import "XPAPIEngine+Login.h"
#import "XPAPIEngine+User.h"
#import "XPAPIEngine+Subscription.h"
#import "XPAPIEngine+Feed.h"
#import "XPUserManager.h"



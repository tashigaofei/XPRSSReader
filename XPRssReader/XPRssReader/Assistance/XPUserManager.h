//
//  XPUserManager.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPUserManager : NSObject

@property (nonatomic, strong) XPOldReaderUser * activeUserInfo;
@property (nonatomic, strong) NSMutableArray * subscriptions;

+ (id)sharedXPUserManager;
-(NSString*) getActiveUserToken;

@end

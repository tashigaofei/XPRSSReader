//
//  XPAPIEngine.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine.h"

@implementation XPAPIEngine

+ (XPAPIEngine *)sharedInstance;
{
    static XPAPIEngine * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XPAPIEngine alloc] initWithHostName:@"www.baidu.com"
                                            customHeaderFields:@{@"User-Agent": @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36 AppEngine-Google; (+http://code.google.com/appengine;)",
                                                        @"Authorization":@"GoogleLogin"}];
        [sharedInstance useCache];
    });
    
    return sharedInstance;
}

@end

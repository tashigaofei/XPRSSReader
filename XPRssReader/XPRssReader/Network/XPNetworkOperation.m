//
//  XPNetworkOperation.m
//  XPRssReader
//
//  Created by tashigaofei on 14-1-1.
//  Copyright (c) 2014年 ZhaoYanJun. All rights reserved.
//

#import "XPNetworkOperation.h"

@implementation XPNetworkOperation


-(void) setCacheHandler:(MKNKResponseBlock) cacheHandler;
{
    NSDate *defaultExpiresDate = [NSDate dateWithTimeIntervalSinceNow:60*5];
    
    [super setCacheHandler:^(MKNetworkOperation* completedCacheableOperation) {
        NSDate * expiresDate = [NSDate dateFromRFC1123:completedCacheableOperation.cacheHeaders[@"Expires"]];
        if (expiresDate == nil || [expiresDate compare:defaultExpiresDate] == NSOrderedAscending) {
            completedCacheableOperation.cacheHeaders[@"Expires"] = [defaultExpiresDate rfc1123String];
        }
        
        cacheHandler(completedCacheableOperation);
    }];
}

@end

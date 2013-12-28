//
//  XPFeedsCache.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-28.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPFeedsCache : NSObject
-(NSMutableArray *) getFeedsOfSubscription:(NSString *) siteURL;
-(BOOL) cacheFeedsOfSubscription:(NSString *) siteURL;
@end

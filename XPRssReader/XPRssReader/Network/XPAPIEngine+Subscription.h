//
//  XPAPIEngine+Subscription.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine.h"

@interface XPAPIEngine (Subscription)

-(MKNetworkOperation *) getActiveUserSubScriptionsCompletionBlock:(void(^)(NSMutableArray* arrary)) completionBlock
                                     failureBlock:(void (^)(NSError* error)) failureBlock;

@end

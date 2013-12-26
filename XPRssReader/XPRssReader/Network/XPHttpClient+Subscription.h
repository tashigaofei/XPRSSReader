//
//  XPHttpClient+Subscription.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient.h"

@interface XPHttpClient (Subscription)

-(void) getActiveUserSubScriptionsCompletionBlock:(void(^)(NSMutableArray* arrary)) completionBlock
                                     failureBlock:(void (^)(NSError* error)) failureBlock;
@end

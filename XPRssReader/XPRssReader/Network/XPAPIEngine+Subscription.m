//
//  XPAPIEngine+Subscription.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine+Subscription.h"

@implementation XPAPIEngine (Subscription)

-(MKNetworkOperation *) getActiveUserSubScriptionsCompletionBlock:(void(^)(NSMutableArray* arrary)) completionBlock
                                     failureBlock:(void (^)(NSError* error)) failureBlock;
{
    
    MKNetworkOperation *op = [[XPAPIEngine sharedInstance] operationWithURLString:
                              @"https://theoldreader.com/reader/api/0/subscription/list"
                            params:@{@"auth": [[XPUserManager sharedXPUserManager] getActiveUserToken],
                                        @"output":@"json"}
                            httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableArray *subscriptions = [NSMutableArray array];
        NSArray *objectArray = [completedOperation responseJSON][@"subscriptions"];
        for (NSDictionary *object in objectArray) {
            XPSubscription *aSubscription = [[XPSubscription alloc] initWithDictionary:object];
            [subscriptions addObject:aSubscription];
        }
        
        if (completionBlock) {
            completionBlock(subscriptions);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        LogError(@"%@", error);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    [[XPAPIEngine sharedInstance] enqueueOperation:op forceReload:NO];
    
    return op;

}

@end

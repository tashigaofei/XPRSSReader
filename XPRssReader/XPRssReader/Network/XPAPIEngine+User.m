//
//  XPAPIEngine+User.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine+User.h"

@implementation XPAPIEngine (User)

-(MKNetworkOperation *) getLoginedUserInfoWithToken:(NSString *) token
                    completionBlock:(void(^)(XPOldReaderUser* token)) completionBlock
                       failureBlock:(void (^)(NSError* error)) failureBlock;
{
    
    MKNetworkOperation *op = [[XPAPIEngine sharedInstance] operationWithURLString:
                              @"https://theoldreader.com/reader/api/0/user-info"
                                                                           params:@{@"auth": token,@"output":@"json"}
                                                                       httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        LogDebug(@"%@", completedOperation.responseString);
        XPOldReaderUser *userInfo = [[XPOldReaderUser alloc] initWithDictionary:[completedOperation responseJSON]];
        userInfo.userToken = token;
        if (completionBlock) {
            completionBlock(userInfo);
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

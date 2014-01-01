//
//  XPAPIEngine+Login.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine+Login.h"

@implementation XPAPIEngine (Login)

-(MKNetworkOperation *) loginOldReaderWithEmail:(NSString *) email password:(NSString *) password
                completionBlock:(void(^)(NSString * token)) completionBlock
                   failureBlock:(void (^)(NSError* error)) failureBlock;
{
      MKNetworkOperation *op = [[XPAPIEngine sharedInstance] operationWithURLString:
                                                    @"https://theoldreader.com/reader/api/0/accounts/ClientLogin"
                                                  params:@{@"client": [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                                                           @"accountType":@"HOSTED",
                                                           @"service":@"reader",
                                                           @"Email": email,
                                                           @"Passwd": password,
                                                           @"output" : @"json"}
                                              httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        LogDebug(@"%@", completedOperation.responseString);
        
        if (completionBlock) {
            completionBlock([completedOperation responseJSON][@"Auth"]);
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

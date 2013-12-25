//
//  XPHttpClient+Login.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient+Login.h"

@implementation XPHttpClient (Login)

-(void) loginOldReaderWithEmail:(NSString *) email password:(NSString *) password
                completionBlock:(void(^)(NSString * token)) completionBlock
                   failureBlock:(void (^)(NSError* error)) failureBlock;
{
    [[XPHttpClient sharedInstance] postPath:@"https://theoldreader.com/reader/api/0/accounts/ClientLogin"
                                 parameters:@{@"client": [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                                              @"accountType":@"HOSTED",
                                              @"service":@"reader",
                                              @"Email": email,
                                              @"Passwd": password,
                                              @"output" : @"json"}
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        LogDebug(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                                        
                                        if (completionBlock) {
                                            completionBlock([responseObject objectFromJSONData]);
                                        }
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        LogError(@"%@", error);
                                        if (failureBlock) {
                                            failureBlock(error);
                                        }
                                    }];
}

@end

//
//  XPHttpClient+User.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient+User.h"

@implementation XPHttpClient (User)

-(void) getLoginedUserInfoWithToken:(NSString *) token
                completionBlock:(void(^)(XPOldReaderUser* token)) completionBlock
                   failureBlock:(void (^)(NSError* error)) failureBlock;
{
    [[XPHttpClient sharedInstance] getPath:@"https://theoldreader.com/reader/api/0/user-info?output=json"
                                parameters:@{@"auth": token}
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       LogDebug(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                                       XPOldReaderUser *userInfo = [[XPOldReaderUser alloc] initWithDictionary:[responseObject objectFromJSONData]];
                                       userInfo.userToken = token;
                                       if (completionBlock) {
                                           completionBlock(userInfo);
                                       }
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       LogError(@"%@", error);
                                       if (failureBlock) {
                                           failureBlock(error);
                                       }
                                   }];
    
}

@end

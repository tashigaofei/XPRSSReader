//
//  XPHttpClient+Subscription.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient+Subscription.h"

@implementation XPHttpClient (Subscription)


-(void) getActiveUserSubScriptionsCompletionBlock:(void(^)(NSMutableArray* arrary)) completionBlock
                       failureBlock:(void (^)(NSError* error)) failureBlock;
{
    [[XPHttpClient sharedInstance] getPath:@"https://theoldreader.com/reader/api/0/subscription/list?output=json"
                                parameters:@{@"auth": [[XPUserManager sharedXPUserManager] getActiveUserToken]}
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
                                       NSMutableArray *subscriptions = [NSMutableArray array];
                                       NSArray *objectArray = [responseObject objectFromJSONData][@"subscriptions"];
                                       for (NSDictionary *object in objectArray) {
                                           XPSubscription *aSubscription = [[XPSubscription alloc] initWithDictionary:object];
                                           [subscriptions addObject:aSubscription];
                                       }
                                       
                                       if (completionBlock) {
                                           completionBlock(subscriptions);
                                       }
                                       
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       LogError(@"%@", error);
                                       if (failureBlock) {
                                           failureBlock(error);
                                       }
                                   }];
    
}



@end

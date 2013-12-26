//
//  XPHttpClient+Feed.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient+Feed.h"

@implementation XPHttpClient (Feed)

- (void) getFeedForURL:(NSString *) url
                   completion:(void (^)(NSArray *feedItems)) completionBlock
                   failure:(void (^)(NSError *error))failureBlock;
{
    
    [[XPHttpClient sharedInstance] getPath:url parameters:nil
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       });
                                       
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       failureBlock(error);
                                       
                                   }];
}

@end

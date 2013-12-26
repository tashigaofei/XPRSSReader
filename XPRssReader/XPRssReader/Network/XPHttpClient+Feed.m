//
//  XPHttpClient+Feed.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient+Feed.h"
#import "RXMLElement.h"

@implementation XPHttpClient (Feed)

- (void) getFeedsForURL:(NSString *) url
                   completion:(void (^)(NSArray *feedItems)) completionBlock
                   failure:(void (^)(NSError *error))failureBlock;
{
    
    [[XPHttpClient sharedInstance] getPath:url parameters:nil
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                           LogInfo(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                                           
                                           RXMLElement *docElement = [[RXMLElement alloc] initFromXMLData:responseObject];
                                           NSMutableArray *array = [NSMutableArray array];
                                           [docElement iterateWithRootXPath:@"//item" usingBlock:^(RXMLElement * e) {
                                               NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                                               [e iterate:@"*" usingBlock:^(RXMLElement *aElement) {
                                                   [dic setObject:aElement.text forKey:aElement.tag];
                                               }];
                                               XPFeed *feed = [[XPFeed alloc] initWithDictionary:dic];
                                               [array addObject:feed];
                                           }];
                                           
                                           if (completionBlock) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completionBlock(array);
                                               });
                                           }
                                       });
                                       
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       LogError(@"%@", error);
                                       if (failureBlock) {
                                           failureBlock(error);
                                       }
                                       
                                   }];
}

@end

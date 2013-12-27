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
                                           NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                           LogInfo(@"%@", responseString);
                                           responseString = [responseString stringByReplacingOccurrencesOfString:@"(?<=\\s)xmlns.*?(?=>)" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [responseString length])];
                                           
                                           RXMLElement *docElement = [[RXMLElement alloc] initFromXMLString:responseString encoding:NSUTF8StringEncoding];
                                           NSMutableArray *array = [NSMutableArray array];
                                           [docElement iterateWithRootXPath:@"//entry|//item" usingBlock:^(RXMLElement * e) {
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

//
//  XPHttpClient+Feed.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient.h"

@interface XPHttpClient (Feed)

- (void) getFeedsForURL:(NSString *) url
             completion:(void (^)(NSMutableArray *feedItems)) completionBlock
                failure:(void (^)(NSError *error))failureBlock;

@end

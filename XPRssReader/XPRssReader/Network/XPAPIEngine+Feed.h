//
//  XPAPIEngine+Feed.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine.h"

@interface XPAPIEngine (Feed)

- (MKNetworkOperation *) getFeedsForURL:(NSString *) url
                             completion:(void (^)(NSMutableArray *feedItems)) completionBlock
                               progress:(MKNKProgressBlock) downloadProgressBlock
                                failure:(void (^)(NSError *error))failureBlock;
@end

//
//  XPAPIEngine+Login.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine.h"

@interface XPAPIEngine (Login)

-(MKNetworkOperation *) loginOldReaderWithEmail:(NSString *) email password:(NSString *) password
                                completionBlock:(void(^)(NSString * token)) completionBlock
                                   failureBlock:(void (^)(NSError* error)) failureBlock;

@end

//
//  XPAPIEngine+User.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine.h"

@interface XPAPIEngine (User)

-(MKNetworkOperation *) getLoginedUserInfoWithToken:(NSString *) token
                                    completionBlock:(void(^)(XPOldReaderUser* token)) completionBlock
                                       failureBlock:(void (^)(NSError* error)) failureBlock;

@end

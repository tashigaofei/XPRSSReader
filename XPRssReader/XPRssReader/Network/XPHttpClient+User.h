//
//  XPHttpClient+User.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient.h"

@interface XPHttpClient (User)


-(void) getLoginedUserInfoWithToken:(NSString *) token
                    completionBlock:(void(^)(XPOldReaderUser* token)) completionBlock
                       failureBlock:(void (^)(NSError* error)) failureBlock;

@end

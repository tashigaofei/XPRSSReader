//
//  XPHttpClient+Login.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient.h"

@interface XPHttpClient (Login)

-(void) loginOldReaderWithEmail:(NSString *) email password:(NSString *) password
                completionBlock:(void(^)(NSString * token)) completionBlock
                   failureBlock:(void (^)(NSError* error)) failureBlock;
@end

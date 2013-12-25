//
//  XPHttpClient.h
//  XPStocks
//
//  Created by tashigaofei on 13-9-25.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "AFHTTPClient.h"
#import "XPSubscription.h"
#import "XPOldReaderUser.h"
#import "JSONKit.h"


typedef void(^StringBlock)(NSString *string);
typedef void(^ErrorBlock)(NSError * error);

@interface XPHttpClient : AFHTTPClient
+ (XPHttpClient *)sharedInstance;
@property (nonatomic, assign) BOOL showNetworkActivity;
@end


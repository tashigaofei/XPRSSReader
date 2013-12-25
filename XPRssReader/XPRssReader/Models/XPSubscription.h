//
//  XPSubscription.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPModel.h"

@interface XPSubscription : XPModel

@property (nonatomic, copy) NSString *objectID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *categories;
@property (nonatomic, copy) NSString *sortid;
@property (nonatomic, copy) NSString *firstitemmsec;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *htmlUrl;
@property (nonatomic, copy) NSString *iconUrl;
@end

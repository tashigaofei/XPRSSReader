//
//  XPSubscription.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPModel.h"

@interface XPSubscription : XPModel

@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSString *sortid;
@property (nonatomic, strong) NSString *firstitemmsec;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *htmlUrl;
@property (nonatomic, strong) NSString *iconUrl;
@end

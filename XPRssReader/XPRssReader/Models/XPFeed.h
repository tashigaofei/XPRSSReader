//
//  XPFeed.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPModel.h"

@interface XPFeed : XPModel

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *objectDescription;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSURL *link;
@property (strong,nonatomic) NSString *objectID;
@property (strong,nonatomic) NSURL *commentsLink;
@property (strong,nonatomic) NSURL *commentsFeed;
@property (strong,nonatomic) NSNumber *commentsCount;
@property (strong,nonatomic) NSString *pubDate;
@property (strong,nonatomic) NSString *author;
@property (strong,nonatomic) NSString * imageURL;

@end

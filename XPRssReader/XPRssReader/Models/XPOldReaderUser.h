//
//  XPOldReaderUser.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPModel.h"

@interface XPOldReaderUser : XPModel

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userProfileId;
@property (nonatomic, copy) NSString *userEmail;
@property (nonatomic, assign, getter=isBloggerUser) BOOL isBloggerUser;
@property (nonatomic, copy) NSString *signupTimeSec;
@property (nonatomic, assign, getter=isMultiLoginEnabled) BOOL isMultiLoginEnabled;

@end

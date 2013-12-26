//
//  XPOldReaderUser.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPModel.h"

@interface XPOldReaderUser : XPModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userToken;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userProfileId;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, assign, getter=isBloggerUser) BOOL isBloggerUser;
@property (nonatomic, strong) NSString *signupTimeSec;
@property (nonatomic, assign, getter=isMultiLoginEnabled) BOOL isMultiLoginEnabled;

@end

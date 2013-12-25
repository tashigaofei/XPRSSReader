//
//  XPOldReaderUser.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPOldReaderUser.h"

@implementation XPOldReaderUser

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.userToken forKey:@"userToken"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.userProfileId forKey:@"userProfileId"];
    [encoder encodeObject:self.userEmail forKey:@"userEmail"];
    [encoder encodeBool:self.isBloggerUser forKey:@"isBloggerUser"];
    [encoder encodeObject:self.signupTimeSec forKey:@"signupTimeSec"];
    [encoder encodeBool:self.isMultiLoginEnabled forKey:@"isMultiLoginEnabled"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.userToken = [decoder decodeObjectForKey:@"userToken"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.userProfileId = [decoder decodeObjectForKey:@"userProfileId"];
        self.userEmail = [decoder decodeObjectForKey:@"userEmail"];
        self.isBloggerUser = [decoder decodeBoolForKey:@"isBloggerUser"];
        self.signupTimeSec = [decoder decodeObjectForKey:@"signupTimeSec"];
        self.isMultiLoginEnabled = [decoder decodeBoolForKey:@"isMultiLoginEnabled"];
    }
    return self;
}

//===========================================================
// - (NSArray *)keyPaths
//
//===========================================================
- (NSArray *)keyPaths
{
    NSArray *result = [NSArray arrayWithObjects:
                       @"userId",
                       @"userToken",
                       @"userName",
                       @"userProfileId",
                       @"userEmail",
                       @"isBloggerUser",
                       @"signupTimeSec",
                       @"isMultiLoginEnabled",
                       nil];
    
    return result;
}

//===========================================================
// - (NSString *)descriptionForKeyPaths
//
//===========================================================
- (NSString *)descriptionForKeyPaths
{
    NSMutableString *desc = [NSMutableString string];
    [desc appendString:@"\n\n"];
    [desc appendFormat:@"Class name: %@\n", NSStringFromClass([self class])];
    
    NSArray *keyPathsArray = [self keyPaths];
    for (NSString *keyPath in keyPathsArray) {
        [desc appendFormat: @"%@: %@\n", keyPath, [self valueForKey:keyPath]];
    }
    
    return [NSString stringWithString:desc];
}
- (NSString *)description 
{
    return [self descriptionForKeyPaths]; 
}

@end

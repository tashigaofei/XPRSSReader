//
//  XPUserManager.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPUserManager.h"

@implementation XPUserManager

+ (id)sharedXPUserManager;
{
    static dispatch_once_t onceQueue;
    static XPUserManager *xPUserManager = nil;
    
    dispatch_once(&onceQueue, ^{ xPUserManager = [[self alloc] init]; });
    return xPUserManager;
}

+(void) initialize
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appResignActiveAction:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
}

+(void) appResignActiveAction:(NSNotification *) notification;
{
    [self storeUserManager:[self sharedXPUserManager]];
}

- (id)init
{
    id object = [[self class] getUserManager];
    if (object) {
        self = object;
    }else{
        self = [super init];
        if (self) {
            
        }
    }
   
    return self;
}

-(NSString*) getActiveUserToken;
{
    NSString *token = _activeUserInfo.userToken;
    NSAssert([token length] > 0, @"error");
    return token;
}

+(XPUserManager *) getUserManager;
{
    XPUserManager *data = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getStoragePath]];
    NSAssert(data == nil || [data isKindOfClass:[XPUserManager class]], @"error");
    
    return data;
}

+(void) storeUserManager:(XPUserManager *) userManager;
{
    BOOL success = [NSKeyedArchiver archiveRootObject:userManager toFile:[self getStoragePath]];
    NSAssert(success, @"error");
    success = YES;
}

+(NSString *) getStoragePath;
{
    NSString *appPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [NSString stringWithFormat:@"%@/XPUserManager.Object", appPath];
}

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.activeUserInfo forKey:@"activeUserInfo"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.activeUserInfo = [decoder decodeObjectForKey:@"activeUserInfo"];
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
                       @"activeUserInfo",
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

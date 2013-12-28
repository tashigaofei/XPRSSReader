//
//  XPFeedsCache.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-28.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPFeedsCache.h"

@interface XPFeedsCache()
{
 
}
@end

@implementation XPFeedsCache

+(instancetype) sharedInstance;
{
    static XPFeedsCache *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XPFeedsCache alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString *appPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *directoryPath = [NSString stringWithFormat:@"%@/%@", appPath, NSStringFromClass([self class])];
        if ( [[NSFileManager defaultManager] fileExistsAtPath:directoryPath] == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}

-(NSString *) getStoragePath:(NSString *) siteURL;
{
    NSString *appPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@", appPath, NSStringFromClass([self class])];
    return [NSString stringWithFormat:@"%@/%d", directoryPath, [siteURL hash]];

}

-(NSMutableArray *) getFeedsOfSubscription:(NSString *) siteURL;
{
    
    return nil;
}

-(BOOL) cacheFeedsOfSubscription:(NSString *) siteURL;
{
    return NO;
}
@end

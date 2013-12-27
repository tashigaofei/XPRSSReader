//
//  XPXMLToFeedParser.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-27.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPXMLToFeedParser.h"

@implementation XPXMLToFeedParser

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+(NSArray *) getFeedStringList:(NSString *) sourceString;
{
    NSError *error;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"<(item|entry)>([\\s\\S]*?)</(item|entry)>"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:&error];
    if (error) {
        LogError(@"%@", error);
        NSAssert(0, @"error");
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [regular enumerateMatchesInString:sourceString options:NSMatchingReportProgress
                                range:NSMakeRange(0, [sourceString length])
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                               if ([result numberOfRanges] == 4) {
                                   [array addObject:[sourceString substringWithRange:[result rangeAtIndex:2]]];
                               }
                           }];
    
    return array;
}


+(NSDictionary*) getObjectFromXMLString:(NSString *) sourceString;
{
    NSError *error;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"<\b(\\S+)\b[^>]*>([\\s\\S]*?)</\1>|<.*?/>"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:&error];
    if (error) {
        LogError(@"%@", error);
        NSAssert(0, @"error");
    }
    
    NSMutableDictionary *dictObject = [NSMutableDictionary dictionary];
    [regular enumerateMatchesInString:sourceString options:NSMatchingReportProgress
                                range:NSMakeRange(0, [sourceString length])
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                               if ([result numberOfRanges] == 3) {
                                   [dictObject setObject:[sourceString substringWithRange:[result rangeAtIndex:2]]
                                                     forKey:[sourceString substringWithRange:[result rangeAtIndex:1]]];
                               }
                           }];
    return dictObject;
}


@end

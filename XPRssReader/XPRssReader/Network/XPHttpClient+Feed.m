//
//  XPHttpClient+Feed.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPHttpClient+Feed.h"

@interface NSString (CDATA)
+(NSString *) bareCDATAString:(NSString *) string;
@end

@implementation NSString(CDATA)
+(NSString *) bareCDATAString:(NSString *) string;
{
    NSString *subString = string;
    if ([subString hasPrefix:@"<![CDATA["]) {
        subString = [subString substringFromIndex:9];
    }
    
    if ([subString hasSuffix:@"]]>"]) {
        subString = [subString substringToIndex:[subString length]-3];
    }
    
    return subString;
}

@end

@implementation XPHttpClient (Feed)

- (void) getFeedsForURL:(NSString *) url
                   completion:(void (^)(NSMutableArray *feedItems)) completionBlock
                   failure:(void (^)(NSError *error))failureBlock;
{
    
    [[XPHttpClient sharedInstance] getPath:url parameters:nil
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                           NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                           LogDebug(@"%@", responseString);
                                           
                                           NSMutableArray *array = [NSMutableArray array];
                                           NSArray *feedXMLs = [[self class] getFeedStringList:responseString];
                                           for (int i = 0; i < [feedXMLs count]; i++) {
                                               NSString *feedXML = feedXMLs[i];
                                               XPFeed *feed = [[XPFeed alloc] initWithDictionary:[[self class] getObjectFromXMLString:feedXML]];
                                               [array addObject:feed];
                                           }
            
                                           if (completionBlock) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   completionBlock(array);
                                               });
                                           }
                                       });
                                       
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       LogError(@"%@", error);
                                       if (failureBlock) {
                                           failureBlock(error);
                                       }
                                       
                                   }];
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
                               if ([result numberOfRanges] == 4 && [result rangeAtIndex:2].length != 0) {
                                   NSString *text = [sourceString substringWithRange:[result rangeAtIndex:2]];
                                   [array addObject:[NSString bareCDATAString:text]];
                               }
                           }];
    
    return array;
}


+(NSDictionary*) getObjectFromXMLString:(NSString *) sourceString;
{
    
    //<title type="html"><![CDATA[iOS 7多任务概要 - 产品经理/工程师版本]]></title>
    NSError *error;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"<\\b(\\S+)\\b[^>]*>([\\s\\S]*?)</\\1>"
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
                               if ([result numberOfRanges] == 3 && [result rangeAtIndex:2].length != 0 && [result rangeAtIndex:1].length != 0) {
                                   NSString *text = [sourceString substringWithRange:[result rangeAtIndex:2]];
                                   [dictObject setObject:[NSString bareCDATAString:text]
                                                  forKey:[sourceString substringWithRange:[result rangeAtIndex:1]]];
                               }
                           }];
    
    
    //<link href="http://www.iwangke.me/2013/11/14/ios-7-multitask-in-a-nut-shell/"/>
    error = nil;
    regular = [[NSRegularExpression alloc] initWithPattern:@"<\\b(\\S+)\\b([^>]*?)=([^>]*)/>"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:&error];
    if (error) {
        LogError(@"%@", error);
        NSAssert(0, @"error");
    }
    
    [regular enumerateMatchesInString:sourceString options:NSMatchingReportProgress
                                range:NSMakeRange(0, [sourceString length])
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                               if ([result numberOfRanges] == 4 && [result rangeAtIndex:2].length != 0 && [result rangeAtIndex:1].length != 0) {
                                   [dictObject setObject:[sourceString substringWithRange:[result rangeAtIndex:3]]
                                                  forKey:[sourceString substringWithRange:[result rangeAtIndex:1]]];
                               }
                           }];
    
    
    return dictObject;
}


@end


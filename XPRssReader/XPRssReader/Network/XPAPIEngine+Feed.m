//
//  XPAPIEngine+Feed.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-31.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPAPIEngine+Feed.h"
#import "NSString+CDATA.h"

@implementation XPAPIEngine (Feed)


- (MKNetworkOperation *) getFeedsForURL:(NSString *) url
             completion:(void (^)(NSMutableArray *feedItems)) completionBlock
                failure:(void (^)(NSError *error))failureBlock;
{
    CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
    
    MKNetworkOperation *op = [[XPAPIEngine sharedInstance] operationWithURLString:url
                                                                           params:nil
                                                                       httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        LogError(@"API finish %f", CFAbsoluteTimeGetCurrent() - time);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
            NSString *responseString = [completedOperation responseString];
            responseString = [NSString bareCDATAString:responseString];
            LogDebug(@"%@", responseString);
            
            NSMutableArray *array = [NSMutableArray array];
            NSArray *feedXMLs = [[self class] getFeedStringList:responseString];
            
            LogError(@"getFeedStringList complete %f", CFAbsoluteTimeGetCurrent() - time);
            
            for (int i = 0; i < [feedXMLs count]; i++) {
                NSString *feedXML = feedXMLs[i];
                XPFeed *feed = [[XPFeed alloc] initWithDictionary:[[self class] getObjectFromXMLString:feedXML]];
                [array addObject:feed];
            }
            
            LogError(@"Parse complete %f", CFAbsoluteTimeGetCurrent() - time);
            
            if (completionBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(array);
                });
            }
        });
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        LogError(@"%@", error);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    [[XPAPIEngine sharedInstance] enqueueOperation:op forceReload:NO];
    
    return op;
    
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
    [regular enumerateMatchesInString:sourceString options:NSMatchingReportCompletion
                                range:NSMakeRange(0, [sourceString length])
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                               if ([result numberOfRanges] == 4 && [result rangeAtIndex:2].length != 0) {
                                   NSString *text = [sourceString substringWithRange:[result rangeAtIndex:2]];
                                   [array addObject:text];
                               }
                           }];
    
    return array;
}

+(NSString *) keyTagsString;
{
    NSString *string = [[XPFeed keyTags] componentsJoinedByString:@"|"];
#ifdef DEBUG
    //    string = [NSString stringWithFormat:@"%@|\\S+", string];
#endif
    return string;
}

+(NSDictionary*) getObjectFromXMLString:(NSString *) sourceString;
{
    
    //<title type="html"><![CDATA[iOS 7多任务概要 - 产品经理/工程师版本]]></title>
    
    NSString *regularExpression = [NSString stringWithFormat:@"<\\b(%@)\\b[^>]*>([\\s\\S]*?)</\\1>",[[self class] keyTagsString]];
    NSError *error;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern: regularExpression
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:&error];
    if (error) {
        LogError(@"%@", error);
        NSAssert(0, @"error");
    }
    
    NSMutableArray *matchRanges = [NSMutableArray array];
    NSMutableDictionary *dictObject = [NSMutableDictionary dictionary];
    [regular enumerateMatchesInString:sourceString options:NSMatchingReportCompletion
                                range:NSMakeRange(0, [sourceString length])
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                               if ([result numberOfRanges] == 3 && [result rangeAtIndex:2].length != 0 && [result rangeAtIndex:1].length != 0) {
                                   NSString *text = [sourceString substringWithRange:[result rangeAtIndex:2]];
                                   [dictObject setObject:text
                                                  forKey:[sourceString substringWithRange:[result rangeAtIndex:1]]];
                                   [matchRanges addObject:[NSValue valueWithRange:result.range]];
                               }
                           }];
    
    //<link href="http://www.iwangke.me/2013/11/14/ios-7-multitask-in-a-nut-shell/"/>
    
    regularExpression = [NSString stringWithFormat:@"<\\b(%@)\\b([^>]*?)=([^>]*)/>",[[self class] keyTagsString]];
    error = nil;
    regular = [[NSRegularExpression alloc] initWithPattern:regularExpression
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:&error];
    if (error) {
        LogError(@"%@", error);
        NSAssert(0, @"error");
    }
    
    NSUInteger length = 0;
    NSUInteger offset = 0;
    NSRange matchRange;
    
    for (int i = 0; i <= [matchRanges count]; i++) {
        if (i == [matchRanges count]) {
            length = [sourceString length] - offset;
        }else{
            matchRange = [matchRanges[i] rangeValue];
            length = matchRange.location - offset;
        }
        
        [regular enumerateMatchesInString:sourceString options:0 range:NSMakeRange(offset, length)
                               usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                   if ([result numberOfRanges] == 4 && [result rangeAtIndex:2].length != 0 && [result rangeAtIndex:1].length != 0) {
                                       [dictObject setObject:[sourceString substringWithRange:[result rangeAtIndex:3]]
                                                      forKey:[sourceString substringWithRange:[result rangeAtIndex:1]]];
                                   }
                                   
                               }];
        
        offset = matchRange.location + matchRange.length;
    }
    
    return dictObject;
}

@end

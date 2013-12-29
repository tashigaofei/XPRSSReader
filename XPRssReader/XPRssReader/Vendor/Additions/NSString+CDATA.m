//
//  NSString+CDATA.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-29.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "NSString+CDATA.h"
@implementation NSString(CDATA)

+(NSString *) bareCDATAString:(NSString *) string;
{
    CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
    
    NSMutableString *subString = [NSMutableString stringWithString:string];
    NSString *regularExpression = @"<!\\[CDATA\\[([\\s\\S]*?)\\]\\]>";
    NSError *error;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern: regularExpression
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:&error];
    if (error) {
        LogError(@"%@", error);
        NSAssert(0, @"error");
    }
    
    NSTextCheckingResult *result = nil;
    NSUInteger offset = 0;
    NSUInteger length = [subString length];
    while ((result = [regular firstMatchInString:subString
                                         options:0
                                           range:NSMakeRange(offset, length)]) != nil) {
        if ([result rangeAtIndex:1].location != NSNotFound) {
            [subString replaceCharactersInRange:result.range withString:[subString substringWithRange:[result rangeAtIndex:1]]];
        }
        offset = result.range.location - 9 + [result rangeAtIndex:1].length;
        length = [subString length] - offset;
    }
    
    LogError(@"bareCDATA  finish %f", CFAbsoluteTimeGetCurrent() -time);
    
    return subString;
}

@end
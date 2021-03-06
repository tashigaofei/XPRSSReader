//
//  XPModel.m
//  XPStocks
//
//  Created by tashigaofei on 13-9-25.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "XPModel.h"

@implementation XPModel

- (id)initWithDictionary:(NSDictionary *) dic;
{
    self = [super init];
    if (self) {
        NSAssert([dic isKindOfClass:[NSDictionary class]], @"eror");
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(NSDictionary *) dictionaryRepresention;
{
    return [self dictionaryWithValuesForKeys:[self keyPaths]];
}

- (id)valueForKey:(NSString *)key;
{
    return  [[super valueForKey:key] description];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
//    NSAssert(0, @"error");
    LogWarn(@"undefind key:------ %@ : \n %@", key, value);
}

-(NSArray *)keyPaths;
{
    return nil;
}

@end

//
//  XPSubscription.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPSubscription.h"

@implementation XPSubscription

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.objectID = value;
        return;
    }
    
    if ([key isEqualToString:@"categories"]) {
        self.categories = [(NSString *) value componentsSeparatedByString:@","];
        return;
    }
    
    [super setValue:value forKey:key];
    
}


//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.objectID forKey:@"objectID"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.categories forKey:@"categories"];
    [encoder encodeObject:self.sortid forKey:@"sortid"];
    [encoder encodeObject:self.firstitemmsec forKey:@"firstitemmsec"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.htmlUrl forKey:@"htmlUrl"];
    [encoder encodeObject:self.iconUrl forKey:@"iconUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.objectID = [decoder decodeObjectForKey:@"objectID"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.categories = [decoder decodeObjectForKey:@"categories"];
        self.sortid = [decoder decodeObjectForKey:@"sortid"];
        self.firstitemmsec = [decoder decodeObjectForKey:@"firstitemmsec"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.htmlUrl = [decoder decodeObjectForKey:@"htmlUrl"];
        self.iconUrl = [decoder decodeObjectForKey:@"iconUrl"];
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
                       @"objectID",
                       @"title",
                       @"categories",
                       @"sortid",
                       @"firstitemmsec",
                       @"url",
                       @"htmlUrl",
                       @"iconUrl",
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

//
//  XPFeed.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-26.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPFeed.h"

@implementation XPFeed

- (id)initWithDictionary:(NSDictionary *) dic;
{
    self = [super initWithDictionary:dic];
    if (self) {
        self.content = self.content == nil ? self.objectDescription : self.content;
    }
    
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"] || [key isEqualToString:@"guid"]) {
        self.objectID = value;
        return;
    }
    if ([key isEqualToString:@"title"]) {
        self.title = value;
        return;
    }
    if ([key isEqualToString:@"link"]) {
        self.link = value;
        return;
    }
    if ([key isEqualToString:@"description"]) {
        self.objectDescription = value;
        return;
    }
    if ([key isEqualToString:@"content:encoded"] || [key isEqualToString:@"content"]) {
        self.content = value;
        return;
    }
    if ([key isEqualToString:@"comments"]) {
        self.commentsLink = value;
        return;
    }
    if ([key isEqualToString:@"wfw:commentRss"]) {
        self.commentsFeed = [NSURL URLWithString:value];
        return;
    }
    if ([key isEqualToString:@"slash:comments"]) {
        self.commentsCount = @([value intValue]);
        return;
    }
    if ([key isEqualToString:@"pubDate"] || [key isEqualToString:@"published"]) {
        self.pubDate = value;
        return;
    }
    if ([key isEqualToString:@"dc:creator"]) {
        self.author = value;
        return;
    }
    
    [super setValue:value forKey:key];
    
}

-(NSString*) imageURL;
{
    if (_imageURL == nil) {
        NSArray *imageURLs = [self imagesFromContent];
        if ([imageURLs count] > 0) {
            _imageURL = imageURLs[0];
        }
    }
    
    return _imageURL;
}

-(NSArray *)imagesFromItemDescription
{
    if (self.objectDescription) {
        return [self imagesFromHTMLString:self.objectDescription];
    }
    
    return nil;
}

-(NSArray *)imagesFromContent;
{
    if (self.content) {
        return [self imagesFromHTMLString:self.content];
    }
    
    return nil;
}

#pragma mark - retrieve images from html string using regexp (private methode)

-(NSArray *)imagesFromHTMLString:(NSString *)htmlstr
{
    NSMutableArray *imagesURLStringArray = [[NSMutableArray alloc] init];
    
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"((https|http)?)\\S*(png|jpg|jpeg|gif)"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    
    [regex enumerateMatchesInString:htmlstr
                            options:0
                              range:NSMakeRange(0, htmlstr.length)
                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             [imagesURLStringArray addObject:[htmlstr substringWithRange:result.range]];
                         }];
    
    return [NSArray arrayWithArray:imagesURLStringArray];
}

//===========================================================
// - (NSArray *)keyPaths
//
//===========================================================
- (NSArray *)keyPaths
{
    NSArray *result = [NSArray arrayWithObjects:
                       @"title",
                       @"objectDescription",
                       @"content",
                       @"link",
                       @"objectID",
                       @"commentsLink",
                       @"commentsFeed",
                       @"commentsCount",
                       @"pubDate",
                       @"author",
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


//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.objectDescription forKey:@"objectDescription"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.link forKey:@"link"];
    [encoder encodeObject:self.objectID forKey:@"objectID"];
    [encoder encodeObject:self.commentsLink forKey:@"commentsLink"];
    [encoder encodeObject:self.commentsFeed forKey:@"commentsFeed"];
    [encoder encodeObject:self.commentsCount forKey:@"commentsCount"];
    [encoder encodeObject:self.pubDate forKey:@"pubDate"];
    [encoder encodeObject:self.author forKey:@"author"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.objectDescription = [decoder decodeObjectForKey:@"objectDescription"];
        self.content = [decoder decodeObjectForKey:@"content"];
        self.link = [decoder decodeObjectForKey:@"link"];
        self.objectID = [decoder decodeObjectForKey:@"objectID"];
        self.commentsLink = [decoder decodeObjectForKey:@"commentsLink"];
        self.commentsFeed = [decoder decodeObjectForKey:@"commentsFeed"];
        self.commentsCount = [decoder decodeObjectForKey:@"commentsCount"];
        self.pubDate = [decoder decodeObjectForKey:@"pubDate"];
        self.author = [decoder decodeObjectForKey:@"author"];
    }
    return self;
}

#pragma mark -

- (BOOL)isEqual:(XPFeed *)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.link.absoluteString isEqualToString:object.link.absoluteString];
}

- (NSUInteger)hash
{
    return [self.link hash];
}

@end

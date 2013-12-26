//
//  XPSubscriptionsTable.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPSubscriptionsTable.h"

@interface XPSubscriptionsTable()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XPSubscriptionsTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = themeBgColor;
    }
    return self;
}

#pragma mark UITableViewDelegate Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_tableDataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    XPSubscription *object = _tableDataSource[indexPath.row];
    cell.textLabel.text = object.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.2 alpha:0.9];
    [cell.imageView setImageWithURL:[NSURL URLWithString:object.iconUrl]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self deselectRowAtIndexPath:indexPath animated:YES];
//    if ([_tableDelegate respondsToSelector:@selector(audioListTable:didSelectAudio:)]) {
//        [_tableDelegate audioListTable:self didSelectAudio:_tableDataSource[indexPath.row]];
//    }
}


@end

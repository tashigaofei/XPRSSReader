//
//  XPSubscriptionsTable.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPSubscriptionsTable;

@protocol XPSubscriptionsTableDelegate <NSObject>
-(void) subscriptionsTable:(XPSubscriptionsTable *) table didSelectAudio:(XPSubscription *) subscription;
@end

@interface XPSubscriptionsTable : UITableView
@property (nonatomic, strong) NSMutableArray * tableDataSource;
@property (nonatomic, weak) id<XPSubscriptionsTableDelegate> tableDelegate;

@end

//
//  XPSiteFeedListTable.h
//  XPRssReader
//
//  Created by tashigaofei on 13-12-28.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPSiteFeedListTable;

@protocol XPSitFeedListTableDelegate <NSObject>
-(void) siteFeedListTable:(XPSiteFeedListTable *) table didSelectFeed:(XPFeed *) feed;
@end

@interface XPSiteFeedListTable : UITableView
@property (nonatomic, strong) NSMutableArray * tableDataSource;
@property (nonatomic, weak) id<XPSitFeedListTableDelegate> tableDelegate;

@end

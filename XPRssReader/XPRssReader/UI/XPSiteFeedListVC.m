//
//  XPSiteFeedListVC.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-27.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPSiteFeedListVC.h"
#import "XPSiteFeedListTable.h"
#import "XPFeedBrowserVC.h"

@interface XPSiteFeedListVC ()<XPSitFeedListTableDelegate>
@property (nonatomic, strong) XPSubscription * subscription;
@property (nonatomic, strong) XPSiteFeedListTable * tableView;
@end

@implementation XPSiteFeedListVC

- (id)initWithSubscription:(XPSubscription *) subscription;
{
    self = [super init];
    if (self) {
        self.subscription = subscription;
    }
    return self;
}
-(void) loadView;
{
    [super loadView];
    
    _tableView = [[XPSiteFeedListTable alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-20-44)];
    _tableView.tableDelegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[XPAPIEngine sharedInstance] getFeedsForURL:_subscription.url completion:^(NSMutableArray *feedItems) {
        [_tableView setTableDataSource:feedItems];
        [_tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        LogError(@"%@", error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) siteFeedListTable:(XPSiteFeedListTable *) table didSelectFeed:(XPFeed *) feed;
{
    XPFeedBrowserVC * vc = [[XPFeedBrowserVC alloc] initWithFeed:feed];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

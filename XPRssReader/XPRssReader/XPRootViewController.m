//
//  XPViewController.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPRootViewController.h"
#import "XPSubscriptionsTable.h"
#import "XPSiteFeedListVC.h"

@interface XPRootViewController ()<XPSubscriptionsTableDelegate>
{
    XPSubscriptionsTable *_tableView;
}
@end

@implementation XPRootViewController

-(void) loadView
{
    [super loadView];
    
    _tableView = [[XPSubscriptionsTable alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-20-44)];
    _tableView.tableDelegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                          target:self action:@selector(rightBarButtonAction:)];
    
    if ([[XPUserManager sharedXPUserManager] subscriptions] == nil) {
        [self reGetSubscription];
    }else{
        [_tableView setTableDataSource:[[XPUserManager sharedXPUserManager] subscriptions]];
        [_tableView reloadData];
    }
}

-(void) rightBarButtonAction:(UIBarButtonItem*) sender;
{
    [self reGetSubscription];
}

-(void) reGetSubscription;
{
    [self getUserInfoWithCompletionBlock:^(XPOldReaderUser *user) {
        [[XPUserManager sharedXPUserManager] setActiveUserInfo:user];
        
        [[XPAPIEngine sharedInstance] getActiveUserSubScriptionsCompletionBlock:^(NSMutableArray *arrary) {
            [[XPUserManager sharedXPUserManager] setSubscriptions:arrary];
            [_tableView setTableDataSource:arrary];
            [_tableView reloadData];
            
        } failureBlock:^(NSError *error) {
            LogError(@"%@", error);
        }];
    } failureBlock:^(NSError *error) {
        
    }];
    
}

-(void) getUserInfoWithCompletionBlock:(void (^)(XPOldReaderUser * user)) completionBlock
                          failureBlock:(void (^)(NSError* error)) failureBlock;
{
    [[XPAPIEngine sharedInstance] loginOldReaderWithEmail:@"tashigaofei@gmail.com"
                                                  password:@"Tashi123"
                                           completionBlock:^(NSString *token) {
                                               LogDebug(@"%@", token);
                                            
            [[XPAPIEngine sharedInstance] getLoginedUserInfoWithToken:token
                                                       completionBlock:^(XPOldReaderUser *userinfo) {
                                                           LogDebug(@"%@", userinfo);
                                                           if (completionBlock) {
                                                               completionBlock(userinfo);
                                                           }
                                                       } failureBlock:^(NSError *error) {
                                                           LogError(@"%@", error);
                                                           if (failureBlock) {
                                                               failureBlock(error);
                                                           }
                                                       }];
                                               
        } failureBlock:^(NSError *error) {
            LogError(@"%@", error);
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) subscriptionsTable:(XPSubscriptionsTable *) table didSelectAudio:(XPSubscription *) subscription;
{
    LogInfo(@"enter %@", subscription.url);
    
    XPSiteFeedListVC *vc = [[XPSiteFeedListVC alloc] initWithSubscription:subscription];
    [self.navigationController pushViewController:vc animated:YES];

}

@end

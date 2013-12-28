//
//  XPViewController.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-25.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPRootViewController.h"

#import "XPHttpClient+Login.h"
#import "XPHttpClient+User.h"
#import "XPUserManager.h"
#import "XPHttpClient+Subscription.h"
#import "XPHttpClient+Feed.h"
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
    
    _tableView = [[XPSubscriptionsTable alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _tableView.tableDelegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    if ([[XPUserManager sharedXPUserManager] subscriptions] == nil) {
        [self getUserInfoWithCompletionBlock:^(XPOldReaderUser *user) {
            [[XPUserManager sharedXPUserManager] setActiveUserInfo:user];
            [[XPHttpClient sharedInstance] getActiveUserSubScriptionsCompletionBlock:^(NSMutableArray *arrary) {
                LogDebug(@"%@", arrary);
                [[XPUserManager sharedXPUserManager] setSubscriptions:arrary];
                [_tableView setTableDataSource:arrary];
                [_tableView reloadData];
                
            } failureBlock:^(NSError *error) {
                LogError(@"%@", error);
            }];
        } failureBlock:^(NSError *error) {
            
        }];
      
    }else{
        [_tableView setTableDataSource:[[XPUserManager sharedXPUserManager] subscriptions]];
        [_tableView reloadData];
    }
    
    
}

-(void) getUserInfoWithCompletionBlock:(void (^)(XPOldReaderUser * user)) completionBlock failureBlock:(void (^)(NSError* error)) failureBlock;
{
    [[XPHttpClient sharedInstance] loginOldReaderWithEmail:@"tashigaofei@gmail.com"
                                                  password:@"Tashi123"
                                           completionBlock:^(NSString *token) {
                                               LogDebug(@"%@", token);
                                            
            [[XPHttpClient sharedInstance] getLoginedUserInfoWithToken:token
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

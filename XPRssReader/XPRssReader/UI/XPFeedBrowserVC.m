//
//  XPFeedBrowserVC.m
//  XPRssReader
//
//  Created by tashigaofei on 13-12-27.
//  Copyright (c) 2013年 ZhaoYanJun. All rights reserved.
//

#import "XPFeedBrowserVC.h"

@interface XPFeedBrowserVC ()<UIWebViewDelegate>
@property (nonatomic, strong) XPFeed *feed;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, assign) int textFontSize;
@end

@implementation XPFeedBrowserVC

- (id)initWithFeed:(XPFeed*) feed;
{
    self = [super init];
    if (self) {
        self.feed = feed;
    }
    return self;
}

-(void) loadView;
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"A+"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(changeWevViewFontSize:)];
    self.navigationItem.rightBarButtonItem.tag = 10000 + 2;
}



-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.webView loadHTMLString:[NSString stringWithFormat:@"<html><body>%@</body></html>", _feed.content] baseURL:nil];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    self.textFontSize = 260;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setTextFontSize:(int)textFontSize;
{
    _textFontSize = textFontSize;
    NSString *javaScript = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='%d%%'";
    NSString *jsString = [[NSString alloc] initWithFormat:javaScript, _textFontSize];
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
    [self.webView setNeedsLayout];
}


- (void) changeWevViewFontSize:(id)sender
{
    switch ([sender tag]-10000) {
        case 1: // A-
            self.textFontSize = self.textFontSize -10;
            break;
        case 2: // A+
            self.textFontSize = self.textFontSize +10;
            break;
    }
}

@end

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
        _textFontSize = 100;
    }
    return self;
}

-(void) loadView;
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-20-44)];
//    _webView.scalesPageToFit = YES;
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
}



-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    <script type=\"text/javascript\" src=\"readability.js\"></script>\
//    <link href=\"readability.css\" rel=\"stylesheet\"/>\
    
    NSString *html =[NSString stringWithFormat:@"<html>\
                     <style type=\"text/css\">\
                     body {background-color:0xf5f5f5;font-size:16px;}\
                     p {margin-left:10px; margin-right:10px;text-indent:2em;}\
                     img {width:270px; height:auto;  display: block; margin-left: auto; margin-right: auto;}\
                     </style>\
                     <body>%@</body>\
                     </html>\
                     ", _feed.content];
   NSString *basePath = [[NSBundle mainBundle] bundlePath];
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:basePath]];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
//    self.textFontSize = self.textFontSize;
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
    self.textFontSize = self.textFontSize +10;
    if (self.textFontSize > 300) {
        self.textFontSize = 100;
    }
}

@end

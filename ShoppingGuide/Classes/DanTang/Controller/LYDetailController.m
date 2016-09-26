//
//  LYDetailController.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYDetailController.h"
#import "SVProgressHUD.h"
#import "LYItem.h"

@interface LYDetailController ()<UIWebViewDelegate>

/**
 *  webView
 */
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LYDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"攻略详情";
    [self.view addSubview:self.webView];
    // 加载数据
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.content_url]]];
}

#pragma mark - lazy load

- (UIWebView *)webView {
    
    if(!_webView) {
        UIWebView *web = [[UIWebView alloc] init];
        web.frame = self.view.bounds;
        web.scalesPageToFit = YES;
        web.dataDetectorTypes = UIDataDetectorTypeAll;
        web.delegate = self;
        _webView = web;
    }
    
    return _webView;
}

#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:@"数据加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD showSuccessWithStatus:@"加载完成!"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"出错啦~"];
}
@end

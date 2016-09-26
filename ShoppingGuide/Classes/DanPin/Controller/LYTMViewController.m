//
//  LYTMViewController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/20.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYTMViewController.h"
#import "LYProduct.h"

@interface LYTMViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LYTMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"checkUserType_backward_9x15_"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackClick)];
    /// 自动对页面进行缩放以适应屏幕
    self.webView.scalesPageToFit = YES;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.product.purchase_url]]];
}

// 返回事件
- (void)navigationBackClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

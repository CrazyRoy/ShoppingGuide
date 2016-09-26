//
//  LYProductDetailController.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/6.
//  Copyright © 2016年 Andrew554. All rights reserved.
//  商品详情

#import "LYProductDetailController.h"
#import "LYProductDetailToolBar.h"
#import "MRNavigationController.h"
#import "LYDetailScrollView.h"
#import "LYActionSheetView.h"
#import "LYTMViewController.h"
#import "LYProduct.h"


@interface LYProductDetailController ()<LYProductDetailToolBarDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) LYDetailScrollView *scrollView;

@property (nonatomic, strong) LYProductDetailToolBar *toolBar;

@end

@implementation LYProductDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setProduct:(LYProduct *)product {
    _product = product;
    
    self.scrollView.product = product;
}

// 设置导航栏和底部工具栏
- (void)setupUI {
    self.title = @"商品详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"GiftShare_icon_18x22_"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    
    // 添加详情视图
    [self.view addSubview:self.scrollView];
    
    // 详情页面底部工具条
    self.toolBar.frame = CGRectMake(0, MRScreenH-45, MRScreenW, 45);
    [self.view addSubview:self.toolBar];
}

// 点击分享
- (void)shareItemClick {
    // 弹出分享框
    [LYActionSheetView show];
}

#pragma mark - 懒加载

- (LYDetailScrollView *)scrollView {
    
    if(!_scrollView) {
        LYDetailScrollView *sc = [[LYDetailScrollView alloc] init];
        sc.frame = CGRectMake(0, 0, MRScreenW, MRScreenH - 44);
        sc.contentSize = CGSizeMake(MRScreenW, MRScreenH - 64 - 45 + kMargin + 520);
        sc.delegate = self;
        _scrollView = sc;
    }
    
    return _scrollView;
}

- (LYProductDetailToolBar *)toolBar {
    
    if(!_toolBar) {
        LYProductDetailToolBar *toolBar = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LYProductDetailToolBar class]) owner:nil options:nil] lastObject];
        toolBar.delegate = self;
        _toolBar = toolBar;
    }
    
    return _toolBar;
}

#pragma mark - <LYProductDetailToolBarDelegate>

// 点击去天猫购买
- (void)toolBarDidClickedTMALLButton {
    LYTMViewController *TMVc = [[LYTMViewController alloc] init];
    TMVc.product = self.product;
    MRNavigationController *nav = [[MRNavigationController alloc] initWithRootViewController:TMVc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 当向下滑动超过一定的返回固定contentOffset.y值
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY >= 465) {
        offsetY = 465.0;
        scrollView.contentOffset = CGPointMake(0, offsetY);
    }
}

@end

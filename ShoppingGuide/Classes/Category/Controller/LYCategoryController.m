//
//  LYCategoryController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/1.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYCategoryController.h"
#import "LYSearchController.h"
#import "LYThemeCollectionController.h"
#import "LYCollectionDetailController.h"
#import "LYCategoryBottomView.h"

@interface LYCategoryController ()<LYCategoryGroupDelegate>

@end

@implementation LYCategoryController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Feed_SearchBtn_18x18_"] style:UIBarButtonItemStylePlain target:self action:@selector(categorySearchClick)];

    // 设置下面的视图具体内容
    [self setupScrollView];
}

- (void)setupScrollView {
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.frame = self.view.bounds;
    [self.view addSubview:sc];
    
    LYThemeCollectionController *themeVc = [[LYThemeCollectionController alloc] init];
    [self addChildViewController:themeVc];
    themeVc.view.frame = CGRectMake(0, 0, MRScreenW, 140);
    [sc addSubview:themeVc.view];
    
    LYCategoryBottomView *bottomView = [[LYCategoryBottomView alloc] init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(themeVc.view.frame) + 10, MRScreenW, MRScreenH - 150);
    bottomView.groupDelegate = self;
    
    [sc addSubview:bottomView];
}

- (void)categorySearchClick {
    LYSearchController *searchVc = [[LYSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark - <LYCategoryGroupDelegate>

- (void)groupButtonItemClcik:(UIButton *)btn {
    LYCollectionDetailController *detailVc = [[LYCollectionDetailController alloc] init];
    detailVc.type = @"风格品类";
    detailVc.id = btn.tag;
    detailVc.title = btn.titleLabel.text;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end

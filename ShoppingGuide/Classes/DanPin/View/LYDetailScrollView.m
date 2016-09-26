//
//  LYDetailScrollView.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYDetailScrollView.h"
#import "LYProduct.h"
#import "LYProductDetailTopView.h"
#import "LYProductDetailBottomView.h"

@interface LYDetailScrollView ()

@property (nonatomic, strong) LYProductDetailTopView *topView;
@property (nonatomic, strong) LYProductDetailBottomView *bottomView;

@end

@implementation LYDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.topView];
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame) + 10, MRScreenW, MRScreenH - 64 - 45);
    [self addSubview:self.bottomView];
}

- (void)setProduct:(LYProduct *)product {
    _product = product;
    
    self.topView.product = product;
    self.bottomView.product = product;
}

#pragma mark - <懒加载>

- (LYProductDetailTopView *)topView {
    
    if(!_topView) {
        LYProductDetailTopView *topView = [[LYProductDetailTopView alloc] init];
        topView.frame = CGRectMake(0, 0, MRScreenW, 520);
        topView.backgroundColor = [UIColor whiteColor];
        _topView = topView;
    }
    
    return _topView;
}

- (LYProductDetailBottomView *)bottomView {
    
    if(!_bottomView) {
        LYProductDetailBottomView *bottomView = [[LYProductDetailBottomView alloc] init];
        bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView = bottomView;
    }
    
    return _bottomView;
}

@end

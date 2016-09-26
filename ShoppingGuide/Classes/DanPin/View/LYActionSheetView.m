//
//  LYActionSheetView.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/6.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYActionSheetView.h"
#import "LYShareBtnsView.h"

@interface LYActionSheetView ()<LYShareBtnDelegate>

/**
 *  顶部
 */
@property (nonatomic, strong) UIView *bgView;

/**
 *  头部
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  中间分享按钮
 */
@property (nonatomic, strong) LYShareBtnsView *shareView;

/**
 *  底部取消
 */
@property (nonatomic, strong) UIButton *cancelBtn;

/**
 *  view
 */
@property (nonatomic, strong) UIView *backView;

@end

@implementation LYActionSheetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化布局
        [self setupUI];
    }
    return self;
}

// 初始化布局
- (void)setupUI {
    // 添加子控件
    UIView *acbg = [[UIView alloc] init];
    acbg.frame = CGRectMake(10, MRScreenH, MRScreenW - 20, 330);
    self.backView = acbg;
    [self addSubview:acbg];
    [acbg addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.shareView];
    [acbg addSubview:self.cancelBtn];
}

// 显示遮罩
+ (void)show {
    
    LYActionSheetView *sheetView = [[LYActionSheetView alloc] init];
    sheetView.frame = [UIScreen mainScreen].bounds;
    sheetView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        sheetView.backView.mr_y = MRScreenH - 330;
    } completion:nil];
 
}

- (void)cancelBtnClicked {
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        self.backView.mr_y = MRScreenH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 懒加载

- (UIView *)bgView {
    
    if(!_bgView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, MRScreenW - 20, 250);
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = kLYCornerRadius;
        view.layer.masksToBounds = YES;
        _bgView = view;
    }
    
    return _bgView;
}

- (UILabel *)titleLabel {
    
    if(!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, self.bgView.mr_width, 50);
        label.text = @"分享到";
        label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    
    return _titleLabel;
}

- (LYShareBtnsView *)shareView {
    
    if(!_shareView) {
        LYShareBtnsView *btnsView = [[LYShareBtnsView alloc] init];
        btnsView.delegate = self;
        btnsView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.bgView.mr_width, 200);
        _shareView = btnsView;
    }
    
    return _shareView;
}

- (UIButton *)cancelBtn {
    
    if(!_cancelBtn) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 265, self.bgView.mr_width, 45);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setTitleColor:MRRGBColor(74, 140, 240) forState:UIControlStateNormal];
        [btn setTitle:@"取 消" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = kLYCornerRadius;
        btn.layer.masksToBounds = YES;
        _cancelBtn = btn;
    }
    
    return _cancelBtn;
}


#pragma mark <LYShareBtnDelegate>  

-(void)shareBtnClickWithTag:(NSInteger)index {
    [self cancelBtnClicked];
}

@end

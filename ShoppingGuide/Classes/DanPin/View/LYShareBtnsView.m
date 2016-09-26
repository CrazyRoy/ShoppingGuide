//
//  LYShareBtnsView.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/6.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYShareBtnsView.h"
#import "MRVerticalButton.h"

@interface LYShareBtnsView ()

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *images;

/**
 *  标题数组
 */
@property (nonatomic, strong) NSArray *titles;

@end

@implementation LYShareBtnsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

// 初始化UI布局
- (void)setupUI {
    
    [self layoutIfNeeded];
}

/**
 *  分享按钮点击
 */
- (void)shareButtonClick:(MRVerticalButton *)btn {
    
    if([self.delegate respondsToSelector:@selector(shareBtnClickWithTag:)]) {
        [self.delegate shareBtnClickWithTag:btn.tag];
    }else {
        NSLog(@"ddd");
    }
}

#pragma mark - 懒加载

- (NSArray *)images {
    
    if(!_images) {
        
        _images = @[@"Share_WeChatTimelineIcon_70x70_", @"Share_WeChatSessionIcon_70x70_", @"Share_WeiboIcon_70x70_", @"Share_QzoneIcon_70x70_", @"Share_QQIcon_70x70_", @"Share_CopyLinkIcon_70x70_"];
        
    }
    
    return _images;
}

- (NSArray *)titles {
    
    if(!_titles) {
        
        _titles = @[@"微信朋友圈", @"微信好友", @"微博", @"QQ 空间", @"QQ 好友", @"复制链接"];
        
    }
    
    return _titles;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger maxCols = 3;  // 列数
    CGFloat width = 70;
    CGFloat height = width + 30;
    CGFloat margin = (self.mr_width - (maxCols * width)) / (maxCols + 1);
    
    for (NSInteger index = 0; index < self.images.count; index++) {
        
        CGFloat x = margin + (margin + width) * (index % maxCols);
        CGFloat y = (index / maxCols) * height;
        MRVerticalButton *btn = [[MRVerticalButton alloc] init];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = index;
        btn.frame = CGRectMake(x, y, width, height);
        [btn setImage:[UIImage imageNamed:self.images[index]] forState:UIControlStateNormal];
        [btn setTitle:self.titles[index] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

@end

//
//  LYMineFooterView.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYMineFooterView.h"
#import "MRNavigationController.h"
#import "LYLoginViewController.h"

@interface LYMineFooterView ()

@property (nonatomic, strong) UIButton *meBlankButton;

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation LYMineFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    [self addSubview:self.meBlankButton];
    
    [self addSubview:self.messageLabel];
}

- (UIButton *)meBlankButton {
    
    if(!_meBlankButton) {
        _meBlankButton = [[UIButton alloc] init];
        _meBlankButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_meBlankButton setImage:[UIImage imageNamed:@"Me_blank_50x50_"] forState:UIControlStateNormal];
        [_meBlankButton.imageView sizeToFit];
        _meBlankButton.frame = CGRectMake((MRScreenW - 100)/2, 0, 100, 100);
        _meBlankButton.mr_centerY = 100;
        
    }
    
    return _meBlankButton;
}

- (UILabel *)messageLabel {
    
    if(!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"登录以享受功能";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:15.0];
        _messageLabel.textColor = MRRGBColor(200, 200, 200);
        _messageLabel.frame = CGRectMake((MRScreenW - 200)/2, 0, 200, 40);
        _messageLabel.mr_centerY = 150;
    }
    
    return _messageLabel;
}

@end

//
//  LYMineHeaderView.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/17.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYMineHeaderView.h"
#import "UIImageView+WebCache.h"
#import "LYNetworkTool.h"
#import "LYUser.h"

@interface LYMineHeaderView ()

@property (nonatomic, strong) UIButton *settingButton;

@property (nonatomic, strong) UIButton *messageButton;

@end

@implementation LYMineHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化UI
        [self setUI];
    }
    return self;
}

- (void)setUI {
    // 添加子控件
    self.bgImageView.frame = CGRectMake(0, -20, MRScreenW, 200);
    [self addSubview:self.bgImageView];
    [self addSubview:self.settingButton];
    [self.messageButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageButton];
    [self.iconButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.iconButton];
    [self addSubview:self.nameLabel];
    
    [self changeStatus];
}

// 根据登录状态修改用户信息
- (void)changeStatus {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        
        NSData *image_data = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar_image"];
        if(image_data == nil) {
        NSString *imageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar_url"];
            [self.iconButton setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]] forState:UIControlStateNormal];
        }else {
            [self.iconButton setBackgroundImage:[UIImage imageWithData:image_data] forState:UIControlStateNormal];
        }
        
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
        self.nameLabel.text = name;
    }else {
        
        [self.iconButton setBackgroundImage:[UIImage imageNamed:@"Me_AvatarPlaceholder_75x75_"] forState:UIControlStateNormal];
        
        self.nameLabel.text = @"登录";
    }
}

#pragma mark - <懒加载>

- (UIImageView *)bgImageView {
    
    if(!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"Me_ProfileBackground"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.backgroundColor = [UIColor yellowColor];
    }
    
    return _bgImageView;
}
//
//- (UIButton *)settingButton {
//    
//    if(!_settingButton) {
//        _settingButton = [[UIButton alloc] init];
//        [_settingButton setImage:[UIImage imageNamed:@"Me_settings_20x20_"] forState:UIControlStateNormal];
//        _settingButton.frame = CGRectMake(MRScreenW - 44, 0, 44, 44);
//    }
//    
//    return _settingButton;
//}

- (UIButton *)messageButton {
    
    if(!_messageButton) {
        _messageButton = [[UIButton alloc] init];
        [_messageButton setImage:[UIImage imageNamed:@"Me_message_20x20_"] forState:UIControlStateNormal];
        _messageButton.frame = CGRectMake(MRScreenW - 44, 0, 44, 44);
    }
    
    return _messageButton;
}

- (UIButton *)iconButton {
    
    if(!_iconButton) {
        _iconButton = [[UIButton alloc] init];
        _iconButton.frame = CGRectMake(0, 0, 75, 75);
        _iconButton.center = self.bgImageView.center;
        _iconButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconButton.layer.borderWidth = 1;
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"Me_AvatarPlaceholder_75x75_"] forState:UIControlStateNormal];
        _iconButton.layer.cornerRadius = _iconButton.mr_width/2;
        _iconButton.layer.masksToBounds = YES;
    }
    
    return _iconButton;
}

- (UILabel *)nameLabel {
    
    if(!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"请登录";
        _nameLabel.frame = CGRectMake(0, CGRectGetMaxY(self.iconButton.frame) + 15, 100, 35);
        _nameLabel.mr_centerX = self.iconButton.mr_centerX;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:15.0];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
       
    }
    
    return _nameLabel;
}

- (void)btnClick:(UIButton *)btn {
    if(btn == self.messageButton) {
        if([self.delegate respondsToSelector:@selector(headerMessageClick:)]) {
            [self.delegate headerMessageClick:btn];
        }
    }else if(btn == self.settingButton) {
        if([self.delegate respondsToSelector:@selector(headerSettingClick:)]) {
            [self.delegate headerSettingClick:btn];
        }
    }else if(btn == self.iconButton) {
        if([self.delegate respondsToSelector:@selector(headerIconClick:)]) {
            [self.delegate headerIconClick:btn];
        }
    }
}
@end

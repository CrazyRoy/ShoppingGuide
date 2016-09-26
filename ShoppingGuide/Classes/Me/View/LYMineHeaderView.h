//
//  LYMineHeaderView.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/17.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYMineHeaderDelegate <NSObject>

@optional

- (void)headerMessageClick:(UIButton *)btn;

- (void)headerSettingClick:(UIButton *)btn;

- (void)headerIconClick:(UIButton *)btn;

@end

@interface LYMineHeaderView : UIView

@property (nonatomic, weak) id<LYMineHeaderDelegate> delegate;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIButton *iconButton;

@property (nonatomic, strong) UILabel *nameLabel;

- (void)changeStatus;

@end

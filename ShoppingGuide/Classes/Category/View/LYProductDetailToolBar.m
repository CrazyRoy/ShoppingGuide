//
//  LYProductDetailToolBar.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYProductDetailToolBar.h"
#import "MRNavigationController.h"
#import "LYLoginViewController.h"
#import "LYUser.h"

@interface LYProductDetailToolBar ()

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *goTMBtn;

@end

@implementation LYProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.likeBtn.layer.borderColor = MRGlobalBg.CGColor;
    self.likeBtn.layer.borderWidth = 1;
    [self.likeBtn setImage:[UIImage imageNamed:@"content-details_like_16x16_"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"content-details_like_selected_16x16_"] forState:UIControlStateSelected];
}

- (IBAction)likeButtonClick:(UIButton *)sender {
    // 判断是否登录
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        sender.selected = !sender.selected;
        // 向服务器发送点赞请求
    }else {
        
        LYLoginViewController *loginVc = [[LYLoginViewController alloc] init];
        loginVc.block = ^(LYUser *user) {
            
            // 保存登录状态
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:user.avatar_url forKey:@"avatar_url"];
            [[NSUserDefaults standardUserDefaults] setObject:user.nickname forKey:@"nickname"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // 发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LYLoginNotification" object:nil];
        };
        MRNavigationController *loginNav = [[MRNavigationController alloc] initWithRootViewController:loginVc];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];
    }
}

- (IBAction)goTMButtonClick:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(toolBarDidClickedTMALLButton)]) {
        [self.delegate toolBarDidClickedTMALLButton];
    }
}


@end

//
//  LYMeMessageController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYMeMessageController.h"

@interface LYMeMessageController ()

@end

@implementation LYMeMessageController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"Me_message_20x20_"];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.layer.cornerRadius = 15;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, 200, 40);
    label.text = @"您暂时还没有消息~";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.mr_centerX = imageView.mr_centerX;
    [self.view addSubview:label];
}
@end

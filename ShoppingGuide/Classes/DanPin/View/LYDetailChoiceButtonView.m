//
//  LYDetailChoiceButtonView.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYDetailChoiceButtonView.h"

@interface LYDetailChoiceButtonView ()

@property (weak, nonatomic) IBOutlet UIButton *detailDescBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LYDetailChoiceButtonView

- (void)awakeFromNib {
    [super awakeFromNib];
}

// 点击图文详情
- (IBAction)detailDescBtnClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.lineView.mr_x = 0;
    }];
    if([self.delegate respondsToSelector:@selector(descBtnClick)]) {
        [self.delegate descBtnClick];
    }
}

// 点击评论
- (IBAction)detailCommentClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.lineView.mr_x = MRScreenW/2;
    }];
    if([self.delegate respondsToSelector:@selector(commentsBtnClick)]) {
        [self.delegate commentsBtnClick];
    }
}

@end

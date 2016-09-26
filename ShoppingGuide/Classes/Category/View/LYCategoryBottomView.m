//
//  LYCategoryBottomView.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/13.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYCategoryBottomView.h"
#import "LYNetworkTool.h"
#import "MJExtension.h"
#import "LYGroup.h"
#import "MRVerticalButton.h"
#import "UIImageView+WebCache.h"
#import "LYCollection.h"

@interface LYCategoryBottomView ()

/**
 *  groups
 */
@property (nonatomic, strong) NSArray *groups;

@end

@implementation LYCategoryBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadGroups];
    }
    return self;
}

- (void)loadGroups {
    __weak typeof(self) weakSelf = self;
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:@"http://api.dantangapp.com/v1/channel_groups/all?" parameters:nil success:^(id  _Nullable responseObject) {
        
        weakSelf.groups = responseObject[@"data"][@"channel_groups"];
        
        [self performSelectorOnMainThread:@selector(setupUI) withObject:nil waitUntilDone:YES];
        
    } failure:nil];
}

- (void)setupUI {

    //风格板块
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.mr_x = 0;
    topView.mr_y = 10;
    topView.mr_width = MRScreenW;
    [self addSubview:topView];
    
    UILabel *labelTop = [self setupLabel:@"风格"];
    [topView addSubview:labelTop];
    
    NSArray *topGroups = [LYGroup mj_objectArrayWithKeyValuesArray:self.groups[0][@"channels"]];
    
    NSInteger cols = 4;
    CGFloat margin = 10;
    CGFloat width = (self.mr_width - ((cols + 1) * margin))/cols;
    CGFloat height = width / 4 * 5;
    for(NSInteger index = 0; index < topGroups.count; index++) {
        LYGroup *group = topGroups[index];
        CGFloat x = (index % cols) * (width + margin) + margin;
        CGFloat y = (index / cols) * height + CGRectGetMaxY(labelTop.frame) - 10;
        MRVerticalButton *btn = [[MRVerticalButton alloc] init];
        btn.tag = group.id;
        [btn addTarget:self action:@selector(groupButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:group.name forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:group.icon_url]]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, y, width, height);
        [topView addSubview:btn];
        
        if(index == topGroups.count - 1) {
            topView.mr_height = CGRectGetMaxY(btn.frame);
        }
    }
    
    
    // 品类板块
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.mr_x = 0;
    bottomView.mr_y = CGRectGetMaxY(topView.frame) + 10;
    bottomView.mr_width = MRScreenW;
    bottomView.mr_height = self.mr_height - bottomView.mr_y;
    [self addSubview:bottomView];
    
    NSArray *bottomGroups = [LYGroup mj_objectArrayWithKeyValuesArray:self.groups[1][@"channels"]];
    
    UILabel *labelBottom = [self setupLabel:@"品类"];
    [bottomView addSubview:labelBottom];
    
    for(NSInteger index = 0; index < bottomGroups.count; index++) {
        LYGroup *group = bottomGroups[index];
        CGFloat x = (index % cols) * (width + margin) + margin;
        CGFloat y = (index / cols) * height + CGRectGetMaxY(labelBottom.frame) - 5;
        MRVerticalButton *btn = [[MRVerticalButton alloc] init];
        btn.tag = group.id;
        [btn addTarget:self action:@selector(groupButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:group.name forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:group.icon_url]]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, y, width, height);
        [bottomView addSubview:btn];
        
        if(index == bottomGroups.count - 1) {
            bottomView.mr_height = self.mr_height - CGRectGetMaxY(btn.frame) - 15;
        }
    }
}

- (UILabel *)setupLabel:(NSString *)title {
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 5, 100, 40);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = title;
    return label;
}

- (void)groupButtonClick:(UIButton *)groupBtn {
    
    if([self.groupDelegate respondsToSelector:@selector(groupButtonItemClcik:)]) {
        
        [self.groupDelegate groupButtonItemClcik:groupBtn];
    }else {
        MRLog(@"%@", groupBtn.titleLabel.text);
    }
}

@end

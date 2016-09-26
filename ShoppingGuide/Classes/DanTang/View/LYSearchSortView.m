//
//  LYSearchSortView.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/10.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYSearchSortView.h"

@interface LYSearchSortView ()<UITableViewDelegate, UITableViewDataSource>

/**
 *  tableView
 */
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *items;

/**
 *  数据
 */
@property (nonatomic, strong) NSArray *apis;

@end

static NSString * const sortViewCellID = @"sortCell";

@implementation LYSearchSortView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}

- (void)setUp {
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    UIImageView *bgIv = [[UIImageView alloc] init];
    bgIv.frame = CGRectMake(MRScreenW - 145, 60, 140, 150);
    bgIv.image = [UIImage imageNamed:@"bg_menu_sort_140x46_"];
    bgIv.userInteractionEnabled = YES;
    [self addSubview:bgIv];
    
    UITableView *tv = [[UITableView alloc] init];
    tv.backgroundColor = [UIColor clearColor];
    tv.delegate = self;
    tv.dataSource = self;
//    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    tv.frame = CGRectMake(0, 10, bgIv.mr_width, bgIv.mr_height-10);
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:sortViewCellID];
    [bgIv addSubview:tv];
    self.tableView = tv;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

#pragma mark - 懒加载

- (NSArray *)items {
    
    if(!_items) {
        
        _items = @[@"默认", @"热度", @"从低到高", @"从高到低"];
        
    }
    
    return _items;
}

- (NSArray *)apis {
    
    if(!_apis) {
        
        _apis = @[@"", @"hot", @"price%3Aasc", @"price%3Adesc"];
        
    }
    
    return _apis;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *sortCell = [tableView dequeueReusableCellWithIdentifier:sortViewCellID];
    sortCell.textLabel.text = self.items[indexPath.row];
    sortCell.selectionStyle = UITableViewCellSelectionStyleNone;
    sortCell.textLabel.textColor = [UIColor whiteColor];
    sortCell.backgroundColor = [UIColor clearColor];
    return sortCell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(sortViewItemDidClick:sortType:)]) {
        [self.delegate sortViewItemDidClick:self sortType:self.apis[indexPath.row]];
    }
    
    // 移除排序视图
    [self dismiss];
}

@end

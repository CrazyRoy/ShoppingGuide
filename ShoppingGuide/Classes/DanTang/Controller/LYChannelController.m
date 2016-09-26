//
//  LYChannelController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYChannelController.h"
#import "LYDetailController.h"
#import "LYNetworkTool.h"
#import "LYItem.h"
#import "MJExtension.h"
#import "LYItemCell.h"
#import "MJRefresh.h"

static NSString * const HomeCell = @"HomeCell";

@interface LYChannelController ()<UITableViewDelegate, UITableViewDataSource>

/**
 * 下一页的请求地址
 */
@property (nonatomic, copy) NSString *next_url;

/**
 *  item数组
 */
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation LYChannelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTable];
    
    // 刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  初始化表格
 */
- (void)setupTable {
    
    self.tableView.contentInset = UIEdgeInsetsMake(LYNavBarHeight + LYTitlesViewH, 0, self.tabBarController.tabBar.mr_height, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 给表格视图添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 给表格视图添加上拉加载
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    
    // 注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYItemCell class]) bundle:nil] forCellReuseIdentifier:HomeCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = LYHomeCellHeight;
}

/**
 *  请求数据
 */
- (void)loadItemInfo:(NSString *)urlString withType:(NSInteger)type{
    
    __weak typeof(self) weakSelf = self;
    
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:urlString parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *dictArr = responseObject[@"data"][@"items"];
        
        NSMutableArray *items = [LYItem mj_objectArrayWithKeyValuesArray:dictArr];
        if(type == 0) { // 下拉刷新
            weakSelf.items = items;
        } else  {   // 上拉加载
            [weakSelf.items addObjectsFromArray:items];
        }
    
        weakSelf.next_url = responseObject[@"data"][@"paging"][@"next_url"];;
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 *  下拉刷新
 */
- (void)loadNewInfo {
    // 拼接参数
    NSString *urlString = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/channels/%ld/items?gender=1&generation=1&limit=20&offset=0", self.channesID];
    
    [self loadItemInfo:urlString withType:0];
}

/**
 *  上拉加载
 */
- (void)loadMoreInfo {
    if(self.next_url != nil && ![self.next_url isEqual:[NSNull null]]) {
        [self loadItemInfo:self.next_url withType:1];
    }else {
        MRLog(@"null");
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.items.count;
}

// 返回对应的单元格视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYItemCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    // 取消选中样式
    LYItem *item = self.items[indexPath.row];
    cell.item = item;   // 设置数据源
    return cell;
}

#pragma mark - Table view delgate

// 单元格的点击事件处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYDetailController *detailVc = [[LYDetailController alloc] init];
    detailVc.item = self.items[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}


#pragma mark - lazy load

- (NSMutableArray *)items {
    
    if(!_items) {
        
        _items = [NSMutableArray array];
        
    }
    
    return _items;
}

@end

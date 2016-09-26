//
//  LYSeeAllTopicController.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/14.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYSeeAllTopicController.h"
#import "LYCollection.h"
#import "MJExtension.h"
#import "LYSeeAllTopicCell.h"
#import "LYNetworkTool.h"
#import "LYCollectionDetailController.h"

@interface LYSeeAllTopicController ()

/**
 *  专题数组
 */
@property (nonatomic, strong) NSArray *collections;

/**
 * 下一页的请求地址
 */
@property (nonatomic, copy) NSString *next_url;

@end

static NSString * seeAllTopicCellID = @"seeAllTopicCellID";

@implementation LYSeeAllTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.title = @"全部专题";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYSeeAllTopicCell class]) bundle:nil] forCellReuseIdentifier:seeAllTopicCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 160;
    
    __weak typeof(self) weakSelf = self;
    
    // 获取 分类界面 顶部 专题合集数据
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:@"http://api.dantangapp.com/v1/collections?limit=20&offset=0" parameters:nil success:^(id  _Nullable responseObject) {
        
        weakSelf.collections = [LYCollection mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"collections"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.collections == nil ? 0 : self.collections.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYSeeAllTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:seeAllTopicCellID];
    cell.collection = self.collections[indexPath.row];
    return cell;
}

#pragma mark - Table view Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LYCollectionDetailController *detailVc = [[LYCollectionDetailController alloc] init];
    LYCollection *collection = self.collections[indexPath.row];
    detailVc.type = @"专题合集";
    detailVc.id = collection.collectionID;
    detailVc.title = collection.title;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end

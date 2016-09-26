//
//  LYCollectionDetailController.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/14.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYCollectionDetailController.h"
#import "LYCollectionPost.h"
#import "LYDetailController.h"
#import "LYNetworkTool.h"
#import "LYItemCell.h"
#import "MJExtension.h"

@interface LYCollectionDetailController ()

/**
 *  collectionPosts
 */
@property (nonatomic, strong) NSArray *posts;

@end

static NSString * LYCollectionDetailCellID = @"LYCollectionTableViewCell";

@implementation LYCollectionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYItemCell class]) bundle:nil] forCellReuseIdentifier:LYCollectionDetailCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = LYHomeCellHeight;
    
    [self loadInfo];
}

- (void)loadInfo {

    __block NSString *url = nil;
    __weak typeof(self) weakSelf = self;
    
    if([weakSelf.type  isEqualToString: @"专题合集"]) {
        url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/collections/%ld/posts?gender=1&generation=1&limit=20&offset=0", self.id];
    }else if([self.type isEqualToString:@"风格品类"]){
        url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/channels/%ld/items?limit=20&offset=0", self.id];
    }
    
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:url parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *dict = nil;
        if([weakSelf.type  isEqualToString: @"专题合集"]) {
            dict = responseObject[@"data"][@"posts"];
        }else if([self.type isEqualToString:@"风格品类"]){
            dict = responseObject[@"data"][@"items"];
        }
        
        weakSelf.posts = [LYCollectionPost mj_objectArrayWithKeyValuesArray:dict];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYItemCell *cell = [tableView dequeueReusableCellWithIdentifier:LYCollectionDetailCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    // 取消选中样式
    LYItem *item = self.posts[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - Table view delgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYDetailController *detailVc = [[LYDetailController alloc] init];
    detailVc.item = self.posts[indexPath.row];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - <懒加载>

- (NSArray *)posts {
    
    if(!_posts) {
        
        _posts = [NSArray array];
        
    }
    
    return _posts;
}

@end

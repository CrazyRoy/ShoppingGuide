//
//  LYDanPingController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/1.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYDanPingController.h"
#import "LYProductDetailController.h"
#import "LYNetworkTool.h"
#import "LYProduct.h"
#import "LYProductCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"

static NSString * const collectionCellID = @"collectionCell";

@interface LYDanPingController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/**
 *  collectionView
 */
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 *  products
 */
@property (nonatomic, strong) NSMutableArray *products;

/**
 * next_url
 */
@property (nonatomic, copy) NSString *next_url;

@end

@implementation LYDanPingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  设置collectionView
    [self setupCollectionView];
    
    // 请求数据
    [self.collectionView.mj_header beginRefreshing];
}


- (void)setupCollectionView {
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LYProductCell class]) bundle:nil] forCellWithReuseIdentifier:collectionCellID];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    
    [self.view addSubview:self.collectionView];
}

- (void)loadProductInfoWithURL:(NSString *)urlString AndType:(LYLoadType)type {
    
    __weak typeof(self)weakSelf = self;
    
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:urlString parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *dicts = responseObject[@"data"][@"items"];
        
        NSMutableArray *pros = [NSMutableArray array];
        
        for (NSDictionary *dic in dicts) {
            LYProduct *product = [LYProduct mj_objectWithKeyValues:dic[@"data"]];
            [pros addObject:product];
        }
    
        weakSelf.next_url = responseObject[@"data"][@"paging"][@"next_url"];
    
        switch (type) {
            case LYLoadTypeNew:
                weakSelf.products = pros;
                break;
                
            case LYLoadTypeMore:
                [weakSelf.products addObjectsFromArray:pros];
                break;
                
            default:
                break;
        }
        
        // 刷新列表数据
        [weakSelf.collectionView reloadData];
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSError * _Nullable error) {
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

// 加载最新
- (void)loadNewInfo {
    
    [self loadProductInfoWithURL:@"http://api.dantangapp.com/v2/items?generation=2&gender=1&limit=20&offset=0" AndType:LYLoadTypeNew];
}

// 加载更多
- (void)loadMoreInfo {
    if(self.next_url != nil && ![self.next_url isEqual:[NSNull null]]) {
        [self loadProductInfoWithURL:self.next_url AndType:LYLoadTypeMore];
    }
}

#pragma mark - lazy load

- (UICollectionView *)collectionView {
    
    if(!_collectionView) {
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        cv.delegate = self;
        cv.dataSource = self;
        _collectionView = cv;
        
    }
    
    return _collectionView;
}

- (NSMutableArray *)products {
    
    if(!_products) {
        
        _products = [NSMutableArray array];
        
    }
    
    return _products;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    LYProduct *product = self.products[indexPath.row];
    cell.product = product;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYProductDetailController *detailVc = [[LYProductDetailController alloc] init];
    LYProduct *product = self.products[indexPath.row];
    detailVc.product = product;
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (MRScreenW - 20) / 2;
    CGFloat height = 245;
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end

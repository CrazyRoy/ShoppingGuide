//
//  LYSearchController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYSearchController.h"
#import "LYProductDetailController.h"
#import "LYNetworkTool.h"
#import "LYProduct.h"
#import "LYProductCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LYSearchSortView.h"

static NSString * const collectionViewCellID = @"searchCell";

@interface LYSearchController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LYSortDelagate>

/**
 *  搜索条
 */
@property (nonatomic, strong) UISearchBar *searchBar;

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

@implementation LYSearchController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (UISearchBar *)searchBar {
    
    if(!_searchBar) {
         _searchBar = [[UISearchBar alloc] init];
         _searchBar.placeholder = @"搜索商品、专题";
    }
    
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
}

// 设置导航栏
- (void)setupNav {
  
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackClick)];
}

- (void)navigationBackClick {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupCollectionView {
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LYProductCell class]) bundle:nil] forCellWithReuseIdentifier:collectionViewCellID];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    
    [self.view addSubview:self.collectionView];
}

- (void)loadProductInfoWithURL:(NSString *)urlString andType:(LYLoadType)type {
    
    __weak typeof(self)weakSelf = self;
    
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:urlString parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *dicts = responseObject[@"data"][@"items"];
        
        NSMutableArray *products = [LYProduct mj_objectArrayWithKeyValuesArray:dicts];
        
        weakSelf.next_url = responseObject[@"data"][@"paging"][@"next_url"];
        
        switch (type) {
            case LYLoadTypeNew:
                weakSelf.products = products;
                break;
                
            case LYLoadTypeMore:
                [weakSelf.products addObjectsFromArray:products];
                break;
                
            default:
                break;
        }
        // 刷新列表数据
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nullable error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

// 加载最新
- (void)loadNewInfoWithKeyword:(NSString *)word sortType:(NSString *)type{
    
    // 拼接请求参数
    NSString *urlStr = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/search/item?keyword=%@&limit=20&offset=0&sort=%@", word, type];
    // 请求搜索结果
    [self loadProductInfoWithURL:urlStr andType:LYLoadTypeNew];
}

// 加载更多
- (void)loadMoreInfo {
    
    if(self.next_url != nil && ![self.next_url isEqual:[NSNull null]]) {
        [self loadProductInfoWithURL:self.next_url andType:LYLoadTypeMore];
    }
}

- (void)sortButtonClick {
    LYSearchSortView *sortView = [[LYSearchSortView alloc] init];
    sortView.delegate = self;
    [sortView show];
}

#pragma mark - <UISearchBarDelegate>

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    //  设置collectionView
    [self setupCollectionView];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // 关闭第一响应者
    [self.searchBar resignFirstResponder];
    
    if([searchBar.text length] > 0) {   // 有输入
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"checkUserType_backward_9x15_"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackClick)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_sort_21x21_"] style:UIBarButtonItemStylePlain target:self action:@selector(sortButtonClick)];

        /// 根据搜索条件进行搜索
        NSString *keyword = searchBar.text;
        [self loadNewInfoWithKeyword:keyword sortType:@""];
        
    }else { // 无输入
        return;
    }
}


#pragma mark - lazy load

- (UICollectionView *)collectionView {
    
    if(!_collectionView) {
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        cv.contentInset = UIEdgeInsetsMake(LYNavBarHeight, 0, 0, 0);
        cv.scrollIndicatorInsets = cv.contentInset;
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
    
    LYProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
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

#pragma mark - <LYSearchSortView>

- (void)sortViewItemDidClick:(LYSearchSortView *)sortView sortType:(NSString *)type {
    // 按照输入的关键字进行搜索
    [self loadNewInfoWithKeyword:self.searchBar.text sortType:type];
}

@end

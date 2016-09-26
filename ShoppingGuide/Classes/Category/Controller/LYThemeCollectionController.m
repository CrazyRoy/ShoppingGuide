//
//  LYThemeCollectionController.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/13.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYThemeCollectionController.h"
#import "LYNetworkTool.h"
#import "MJExtension.h"
#import "LYCollection.h"
#import "LYCategoryCollectionCell.h"
#import "LYSeeAllTopicController.h"
#import "LYCollectionDetailController.h"

@interface LYThemeCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/**
 *  collections
 */
@property (nonatomic, strong) NSArray *collections;

/**
 *  collectionView
 */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

static NSString * const LYCategoryCollectionID = @"categoryCollectionID";

@implementation LYThemeCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:@"http://api.dantangapp.com/v1/collections?limit=20&offset=0" parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *dictArr = responseObject[@"data"][@"collections"];
        weakSelf.collections = [LYCollection mj_objectArrayWithKeyValuesArray:dictArr];
        [weakSelf.collectionView reloadData];
        
    } failure:nil];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.mr_x = 10;
    label.mr_y = 5;
    label.mr_size = CGSizeMake(100, 35);
    label.text = @"专题合集";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"查看全部>" forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.mr_x = self.view.frame.size.width - btn.mr_width - 5;
    btn.mr_centerY = label.mr_centerY;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, MRScreenW, 100) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCategoryCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:LYCategoryCollectionID];
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
}


#pragma mark - <showAll>
- (void)showAll: (UIButton *)btn {
    
    LYSeeAllTopicController *allVc = [[LYSeeAllTopicController alloc] init];
//    allVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:allVc animated:YES];
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LYCollectionDetailController *detailVc = [[LYCollectionDetailController alloc] init];
    LYCollection *collection = self.collections[indexPath.row];
    detailVc.type = @"专题合集";
    detailVc.id = collection.collectionID;
    detailVc.title = collection.title;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYCategoryCollectionID forIndexPath:indexPath];;
    cell.collection = self.collections[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewFlowLayoutDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSArray *)collections {
    
    if(!_collections) {
        
        _collections = [NSArray array];
        
    }
    
    return _collections;
}
@end

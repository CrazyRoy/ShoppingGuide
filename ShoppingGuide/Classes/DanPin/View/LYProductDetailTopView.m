//
//  LYProductDetailTopView.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYProductDetailTopView.h"
#import "LYProduct.h"
#import "LYDetailLayout.h"
#import "LYDetailCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface LYProductDetailTopView ()<UICollectionViewDelegate, UICollectionViewDataSource>

/**
 *  imageURLs, 图片地址数组
 */
@property (nonatomic, strong) NSArray *imageURLs;
// collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
// pageControl
@property (nonatomic, strong) UIPageControl *pageControl;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 价格
@property (nonatomic, strong) UILabel *priceLabel;
// 描述
@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation LYProductDetailTopView

static NSString * const detailCollectionViewCellID = @"detailCollectionViewCellID";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.collectionView];
    CGFloat pageW = 100;
    CGFloat pageH = 40;
    CGFloat pageX = 0;
    CGFloat pageY = self.collectionView.mr_height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    self.pageControl.contentMode = UIViewContentModeCenter;
    [self addSubview:self.pageControl];
    self.titleLabel.frame = CGRectMake(5, CGRectGetMaxY(self.collectionView.frame) + 5, MRScreenW - 10, 30);
    [self addSubview:self.titleLabel];
    self.priceLabel.frame = CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame) + 5, MRScreenW - 10, 25);
    [self addSubview:self.priceLabel];
    self.describeLabel.frame = CGRectMake(5, CGRectGetMaxY(self.priceLabel.frame) + 5, MRScreenW - 10, 40);
    [self addSubview:self.describeLabel];
}

- (void)setProduct:(LYProduct *)product {
    _product = product;
    
    self.imageURLs = product.image_urls;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.imageURLs.count;
    self.pageControl.mr_centerX = self.collectionView.mr_centerX;
    self.titleLabel.text = product.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", product.price];
    self.describeLabel.text = product.describe;
}

#pragma mark - <懒加载>

- (NSArray *)imageURLs {
    
    if(!_imageURLs) {
        
        NSArray *array = [NSArray array];
        _imageURLs = array;
    }
    
    return _imageURLs;
}

- (UICollectionView *)collectionView {
    
    if(!_collectionView) {
        LYDetailLayout *layout = [[LYDetailLayout alloc] init];
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MRScreenW, 375) collectionViewLayout:layout];
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([LYDetailCollectionViewCell class]) bundle:nil];
        [cv registerNib:nib forCellWithReuseIdentifier:detailCollectionViewCellID];
        cv.showsHorizontalScrollIndicator = NO;
        cv.delegate = self;
        cv.dataSource = self;
        cv.backgroundColor = [UIColor whiteColor];
        _collectionView = cv;
    }
    
    return _collectionView;
}

- (UIPageControl *)pageControl {
    
    if(!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl = pageControl;
    }
    
    return _pageControl;
}

- (UILabel *)titleLabel {
    
    if(!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = [UIColor blackColor];
        _titleLabel = label;
    }
    
    return _titleLabel;
}

- (UILabel *)priceLabel {
    
    if(!_priceLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = MRGlobalBg;
        label.font = [UIFont systemFontOfSize:16];
        _priceLabel = label;
    }
    
    return _priceLabel;
}

- (UILabel *)describeLabel {
    
    if(!_describeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        label.font = [UIFont systemFontOfSize:15];
        _describeLabel = label;
    }
    
    return _describeLabel;
}

#pragma mark - <UICollectionViewDelegate, UICollectionDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:detailCollectionViewCellID forIndexPath:indexPath];
    NSString *url = self.imageURLs[indexPath.item];
    MRLog(@"%@", url);
    [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.placeholderBtn.hidden = YES;
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX / scrollView.mr_width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}

@end


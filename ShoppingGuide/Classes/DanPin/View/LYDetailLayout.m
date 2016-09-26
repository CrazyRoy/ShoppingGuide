//
//  LYDetailLayout.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYDetailLayout.h"

@implementation LYDetailLayout

// 准备布局
- (void)prepareLayout {
    [super prepareLayout];
    // 设置layout布局
    self.itemSize = CGSizeMake(MRScreenW, 375);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置contentView属性
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
}

@end

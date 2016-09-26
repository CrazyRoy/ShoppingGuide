//
//  LYCategoryCollectionCell.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/13.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYCategoryCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "LYCollection.h"

@interface LYCategoryCollectionCell ()

@property (weak, nonatomic) IBOutlet UIButton *placeholderBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LYCategoryCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCollection:(LYCollection *)collection {
    _collection = collection;
    
    __weak typeof(self) weakSelf = self;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:collection.banner_image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.placeholderBtn.hidden = YES;
    }];
}

@end

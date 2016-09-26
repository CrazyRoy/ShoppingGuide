//
//  LYProductCell.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYProductCell.h"
#import "LYProduct.h"
#import "UIImageView+WebCache.h"

@interface LYProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) IBOutlet UIButton *placeholderBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end

@implementation LYProductCell


- (void)setProduct:(LYProduct *)product {
    
    _product = product;
    
    self.titleLabel.text = product.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", product.price];
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %ld  ", product.favorites_count] forState:UIControlStateNormal];
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:product.cover_image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.placeholderBtn.hidden = YES;
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
}

@end

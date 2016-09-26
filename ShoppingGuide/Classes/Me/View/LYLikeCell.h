//
//  LYLikeCell.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/20.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYItem;
@class LYProduct;

@interface LYLikeCell : UITableViewCell

@property (nonatomic, strong) LYItem *item;

@property (nonatomic, strong) LYProduct *product;

@end

//
//  LYProductDetailController.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/6.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYBaseViewController.h"

@class LYProduct;

@interface LYProductDetailController : LYBaseViewController

/**
 *  商品
 */
@property (nonatomic, strong) LYProduct *product;

@end

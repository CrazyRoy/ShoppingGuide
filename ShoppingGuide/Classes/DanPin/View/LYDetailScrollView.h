//
//  LYDetailScrollView.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYProduct;

@interface LYDetailScrollView : UIScrollView

/**
 *  product
 */
@property (nonatomic, strong) LYProduct *product;

@end

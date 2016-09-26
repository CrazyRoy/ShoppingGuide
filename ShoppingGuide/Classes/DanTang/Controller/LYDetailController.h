//
//  LYDetailController.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBaseViewController.h"

@class LYItem;

@interface LYDetailController : LYBaseViewController

/**
 *  item
 */
@property (nonatomic, strong) LYItem *item;

@end

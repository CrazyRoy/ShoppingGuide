//
//  LYEditInfoViewController.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/20.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYBaseViewController.h"

@interface LYEditInfoViewController : LYBaseViewController

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) void (^saveFinishBlock)(NSString *name, UIImage *image);

@end

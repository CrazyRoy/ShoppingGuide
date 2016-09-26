//
//  LYLoginViewController.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYBaseViewController.h"
@class LYUser;

typedef void (^LoginSuccessBlock)(LYUser *);

@interface LYLoginViewController : LYBaseViewController

/**
 * 登录成功之后的回调闭包
 */
@property (nonatomic, copy) LoginSuccessBlock block;

@end

//
//  LYCollectionDetailController.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/14.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCollectionDetailController : UITableViewController

/**
 * 类型
 */
@property (nonatomic, copy) NSString *type;

/**
 *  Id
 */
@property (nonatomic, assign) NSInteger id;

@end

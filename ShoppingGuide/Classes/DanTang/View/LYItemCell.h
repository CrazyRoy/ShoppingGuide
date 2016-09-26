//
//  LYItemCell.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYItem;

@interface LYItemCell : UITableViewCell

/**
 *  item
 */
@property (nonatomic, strong) LYItem *item;

@end

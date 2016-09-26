//
//  LYCommentCell.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYComment;

@interface LYCommentCell : UITableViewCell

/**
 *  评论
 */
@property (nonatomic, strong) LYComment *comment;

@end

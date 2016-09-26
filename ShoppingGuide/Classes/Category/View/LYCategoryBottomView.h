//
//  LYCategoryBottomView.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/13.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYCategoryGroupDelegate <NSObject>

@optional

- (void)groupButtonItemClcik:(UIButton *)btn;


@end

@interface LYCategoryBottomView : UIView

/**
 *  协议
 */
@property (nonatomic, weak) id<LYCategoryGroupDelegate> groupDelegate;

@end

//
//  LYShareBtnsView.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/6.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYShareBtnDelegate <NSObject>

@optional

- (void)shareBtnClickWithTag: (NSInteger)index;

@end

@interface LYShareBtnsView : UIView

/**
 *  delegate
 */
@property (nonatomic, weak) id<LYShareBtnDelegate> delegate;

@end

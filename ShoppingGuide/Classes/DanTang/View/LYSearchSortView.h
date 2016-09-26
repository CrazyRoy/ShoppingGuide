//
//  LYSearchSortView.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/10.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYSearchSortView;

typedef enum : NSUInteger {
    LYSortTypeDefault,  // 默认
    LYSortTypeHot,  // 热度
    LYSortTypePriceAase,    // 价格从低到高
    LYSortTypePriceAdese    // 价格从高到低
} LYSortType;

@protocol LYSortDelagate <NSObject>

@optional

- (void)sortViewItemDidClick:(LYSearchSortView *)sortView sortType:(NSString *)type;

@end

@interface LYSearchSortView : UIView

/**
 *  代理协议
 */
@property (nonatomic, weak) id<LYSortDelagate> delegate;

- (void)show;

@end


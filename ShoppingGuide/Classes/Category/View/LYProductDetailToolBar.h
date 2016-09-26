//
//  LYProductDetailToolBar.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYProductDetailToolBarDelegate <NSObject>

@optional

- (void)toolBarDidClickedTMALLButton;

@end

@interface LYProductDetailToolBar : UIView

@property (nonatomic, weak) id<LYProductDetailToolBarDelegate> delegate;

@end

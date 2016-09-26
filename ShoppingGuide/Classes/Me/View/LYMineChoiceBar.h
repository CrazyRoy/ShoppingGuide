//
//  LYMineChoiceBar.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYMineChoiceBarDelegate <NSObject>

@optional

- (void)choiceBarClick:(NSInteger) index;

@end

@interface LYMineChoiceBar : UIView

@property (nonatomic, weak) id<LYMineChoiceBarDelegate> delegate;

@end

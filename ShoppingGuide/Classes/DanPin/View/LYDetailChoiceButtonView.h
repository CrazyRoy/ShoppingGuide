//
//  LYDetailChoiceButtonView.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYDetailChoiceDelegate <NSObject>

- (void)descBtnClick;

- (void)commentsBtnClick;

@end

@interface LYDetailChoiceButtonView : UIView

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (nonatomic, weak) id<LYDetailChoiceDelegate> delegate;

@end

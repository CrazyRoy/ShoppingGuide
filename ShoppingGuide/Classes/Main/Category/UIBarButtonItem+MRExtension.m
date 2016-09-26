//
//  UIBarButtonItem+MRxtension.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/5/31.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "UIBarButtonItem+MRExtension.h"

@implementation UIBarButtonItem (MRExtension)


+ (instancetype)itemWithButtonImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    
    // 创建UIButton
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [customView setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [customView setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    customView.mr_size = customView.currentBackgroundImage.size;
    
    [customView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:customView];
}


@end

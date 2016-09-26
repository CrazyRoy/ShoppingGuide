//
//  UIBarButtonItem+MRxtension.h
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/5/31.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MRExtension)

/**
 *	@brief	自定义custom的UIBarButton
 */
+ (instancetype)itemWithButtonImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end

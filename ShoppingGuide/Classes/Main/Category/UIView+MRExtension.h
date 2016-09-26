//
//  UIView+MRExtension.h
//  MRExtension
//
//  Created by SinObjectC on 16/5/23.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MRExtension)

/** X坐标 */
@property(nonatomic, assign)CGFloat mr_x;

/** Y坐标 */
@property(nonatomic, assign)CGFloat mr_y;

/** x中心点 */
@property(nonatomic, assign)CGFloat mr_centerX;

/** y中心点 */
@property(nonatomic, assign)CGFloat mr_centerY;

/** 坐标 */
@property(nonatomic, assign)CGPoint mr_origin;

/** 宽度 */
@property(nonatomic, assign)CGFloat mr_width;

/** 高度 */
@property(nonatomic, assign)CGFloat mr_height;

/** 尺寸 */
@property(nonatomic, assign)CGSize mr_size;


@end

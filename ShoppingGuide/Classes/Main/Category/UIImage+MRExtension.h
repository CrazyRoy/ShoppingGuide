//
//  UIImage+MRExtension.h
//  MRExtension
//
//  Created by SinObjectC on 16/5/23.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MRExtension)

/**
 *	@brief	生成可拉伸的图片
 *
 *	@param 	imageName 	原始图片名
 *
 *	@return	可拉伸的图片
 */
+ (instancetype)mr_resizingImage:(NSString *)imageName;


/**
 *	@brief	生成一张禁止用系统渲染的图片
 *
 *	@param 	imageName 	原始图片名
 *
 *	@return	禁用系统渲染的图片
 */
+ (instancetype)mr_imageOriginalWithName:(NSString *)imageName;


/**
 *	@brief	带边框(optional)圆形图片裁剪
 *
 *	@param 	clipImageName 	待裁剪图片名
 *	@param 	borderWidth 	圆环宽度
 *	@param 	borderColor 	圆环颜色
 *
 *	@return	裁剪之后的图片
 */
+ (instancetype)mr_imageWithClipImageNamed:(NSString *)clipImageName borderWidth:(CGFloat)borderWidth borderCorlor:(UIColor *)borderColor;


/**
 *	@brief	根据颜色生成一张尺寸为 1*1 的相同颜色图片
 *
 *	@param 	color 	需要转化的颜色
 *
 *	@return	生成一张尺寸为 1*1 相同颜色的图片
 */
+ (instancetype)mr_imageWithColor:(UIColor *)color;


/**
 *	@brief	根据控件返回一张截图
 *
 *	@param 	view 	来源控件
 *
 *	@return	控件截图
 */
+ (instancetype)mr_imageWithCaptureView:(UIView *)view;


@end

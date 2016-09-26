//
//  UIImage+MRExtension.m
//  MRExtension
//
//  Created by SinObjectC on 16/5/23.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "UIImage+MRExtension.h"

@implementation UIImage (MRExtension)

#pragma mark - 拉伸图片
+ (instancetype)mr_resizingImage:(NSString *)imageName {
    
    // 根据图片名创建图片对象
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 找到可拉伸的区域
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    // 获取将图片中间 1*1 拉伸填充铺满之后的新图片
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5 - 1, imageW * 0.5 - 1) resizingMode:UIImageResizingModeStretch];
    
    return image;
}


#pragma mark - 禁止渲染
+ (instancetype)mr_imageOriginalWithName:(NSString *)imageName {
    
    // 根据图片名创建图片对象
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 告诉系统不需要渲染，保持图片原始状态
    image = [image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 返回新的图片
    return image;
}


#pragma mark - 带边框(optional)圆形图片裁剪
+ (instancetype)mr_imageWithClipImageNamed:(NSString *)clipImageName borderWidth:(CGFloat)borderWidth borderCorlor:(UIColor *)borderColor {
    
    UIImage *temp = [UIImage imageNamed:clipImageName];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:temp];

    //注意第三个选项的设置
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, [UIScreen mainScreen].scale);
    
    //在绘制之前先裁剪出一个圆形
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                cornerRadius:borderWidth] addClip];
    //图片在设置的圆形里面进行绘制
    [temp drawInRect:imageView.bounds];
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束绘制
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 颜色生成图片
+ (instancetype)mr_imageWithColor:(UIColor *)color {
    
    // 设置默认大小
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 获取图形上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 填充颜色
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    // 图片填充大小
    CGContextFillRect(ctx, rect);
    
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}


#pragma mark - 控件截图
+ (instancetype)mr_imageWithCaptureView:(UIView *)view {
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);

    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 将控件上的图层渲染上下文
    [view.layer renderInContext:ctx];
    
    // 生成图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}
@end

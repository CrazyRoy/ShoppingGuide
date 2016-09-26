//
//  MRTextField.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/12.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRTextField.h"
#import <objc/runtime.h>

static NSString * const MRPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation MRTextField

+ (void)initialize {
    
    // 运行时RunTime
//    unsigned int count = 0;
//    
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        
//        // 取出成员变量
//        Ivar ivar = *(ivars + i);
//        
//        // 打印成员变量名
//        NSLog(@"%s", ivar_getName(ivar));
//    }

}

- (void)awakeFromNib {
    
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
}

// 当文本框聚焦的时候调用
- (BOOL)becomeFirstResponder {

    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:MRPlaceholderColorKeyPath];
    
    return [super becomeFirstResponder];
}

// 当文本框失去焦点的时候调用
- (BOOL)resignFirstResponder {
    
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:MRPlaceholderColorKeyPath];
    
    return [super resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

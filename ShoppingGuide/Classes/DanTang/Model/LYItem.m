//
//  LYItem.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYItem.h"
#import "MJExtension.h"

@implementation LYItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"itemID"] = @"id";
    return dict;
}

@end

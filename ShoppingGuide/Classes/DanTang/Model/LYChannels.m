//
//  LYChannels.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYChannels.h"

@implementation LYChannels

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"channelsID"] = @"id";
    return dic;
}

@end

//
//  LYCollection.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/13.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYCollection.h"

@implementation LYCollection

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"collectionID"] = @"id";
    return dic;
}
@end

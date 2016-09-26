//
//  LYProduct.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYProduct.h"
#import "MJExtension.h"

@implementation LYProduct

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"productID"] = @"id";
    dict[@"describe"] = @"description";
    return dict;
}

@end

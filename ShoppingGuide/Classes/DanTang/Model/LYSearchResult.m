//
//  LYSearchResult.m
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYSearchResult.h"

@implementation LYSearchResult

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"resultID"] = @"id";
    dict[@"describe"] = @"description";
    return dict;
}

@end

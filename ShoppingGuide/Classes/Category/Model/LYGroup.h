//
//  LYGroup.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/13.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYGroup : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger group_id;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger items_count;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end

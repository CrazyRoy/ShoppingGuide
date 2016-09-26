//
//  LYComment.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYUser.h"

@interface LYComment : NSObject

/**
 *var content: String?
 
 var id: Int?
 
 var created_at: Int?
 
 var show: Bool?
 
 var item_id: Int?
 
 var user: User?
 */

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger item_id;
@property (nonatomic, strong) LYUser *user;

@end

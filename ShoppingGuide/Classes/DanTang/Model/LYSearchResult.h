//
//  LYSearchResult.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface LYSearchResult : NSObject

/**
 *  resultID
 */
@property (nonatomic, assign) NSInteger resultID;
/**
 *  favorites_count
 */
@property (nonatomic, assign) NSInteger favorites_count;

/**
 *  likes_count
 */
@property (nonatomic, assign) NSInteger likes_count;

/**
 * price
 */
@property (nonatomic, copy) NSString *price;

/**
 *  liked
 */
@property (nonatomic, assign) BOOL liked;

/**
 * cover_image_url
 */
@property (nonatomic, copy) NSString *cover_image_url;

/**
 * describe
 */
@property (nonatomic, copy) NSString *describe;

/**
 * name
 */
@property (nonatomic, copy) NSString *name;


@end

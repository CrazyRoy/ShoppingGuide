//
//  LYProduct.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYProduct : NSObject
/**
 *  productID
 */
@property (nonatomic, assign) NSInteger productID;
/**
 * cover_image_url
 */
@property (nonatomic, copy) NSString *cover_image_url;

/**
 *  created_at
 */
@property (nonatomic, assign) NSInteger created_at;

/**
 * describe
 */
@property (nonatomic, copy) NSString *describe;

/**
 *  editor_id
 */
@property (nonatomic, assign) NSInteger editor_id;

/**
 *  favorites_count
 */
@property (nonatomic, assign) NSInteger favorites_count;

/**
 * image_urls
 */
@property (nonatomic, strong) NSArray *image_urls;

/**
 *  is_favorite
 */
@property (nonatomic, assign) BOOL is_favorite;

/**
 * name
 */
@property (nonatomic, copy) NSString *name;

/**
 * price
 */
@property (nonatomic, copy) NSString *price;

/**
 *  purchase_id
 */
@property (nonatomic, assign) NSInteger purchase_id;

/**
 *  purchase_status
 */
@property (nonatomic, assign) NSInteger purchase_status;

/**
 *  purchase_type
 */
@property (nonatomic, assign) NSInteger purchase_type;

/**
 * purchase_url
 */
@property (nonatomic, copy) NSString *purchase_url;

/**
 *  updated_at
 */
@property (nonatomic, assign) NSInteger updated_at;

/**
 * url
 */
@property (nonatomic, copy) NSString *url;


@end

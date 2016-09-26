//
//  LYCollectionPost.h
//  ShoppingGuide
//
//  Created by CoderLL on 16/9/14.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYCollectionPost : NSObject

@property (nonatomic, copy) NSString *cover_image_url;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger published_at;
@property (nonatomic, assign) NSInteger created_at;
@property (nonatomic, copy) NSString *content_url;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *share_msg;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger updated_at;
@property (nonatomic, copy) NSString *short_title;
@property (nonatomic, assign) Boolean liked;
@property (nonatomic, assign) NSInteger likes_count;
@property (nonatomic, assign) NSInteger status;

@end

//
//  LYChannels.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface LYChannels : NSObject

/**
 *  id
 */
@property (nonatomic, assign) NSInteger channelsID;

/**
 *  eidtable
 */
@property (nonatomic, assign) NSInteger editable;

/**
 * name
 */
@property (nonatomic, copy) NSString *name;

@end

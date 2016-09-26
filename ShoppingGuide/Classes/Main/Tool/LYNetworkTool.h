//
//  LYNetworkTool.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYNetworkTool : NSObject<NSCopying>

+ (instancetype)sharedNetworkTool;

- (void)loadDataInfo:(nullable NSString *)URLString
          parameters:(nullable id)parameters
             success:(nullable void (^)(id _Nullable responseObject))success
             failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)loadDataInfoPost:(nullable NSString *)URLString
              parameters:(nullable id)parameters
                 success:(nullable void (^)(id _Nullable responseObject))success
                 failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)loadDataInfoDelete:(nullable NSString *)URLString
            parameters:(nullable id)parameters
                success:(nullable void (^)(id _Nullable responseObject))success
                failure:(nullable void (^)(NSError *_Nullable error))failure;
@end
//
//  LYItem.h
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYItem : NSObject

/**
 
 cover_image_url : http://7fvaoh.com3.z0.glb.qiniucdn.com/image/151027/pktvp21vq.jpg-w720,
	id : 2792,
	published_at : 1451606400,
	template : ,
	editor_id : <null>,
	created_at : 1451606400,
	content_url : http://dantang.liwushuo.com/posts/2792/content,
	labels : [
 ],
	url : http://dantang.liwushuo.com/posts/2792,
	type : post,
	share_msg : 人们都说，一个人的生活环境会对人的性格产生重要的影响，想要做一个有趣又暖心的孩纸，家里一定要温馨又浪漫哦！你们看小编这么惹人喜爱就知道小编的家里不可能平淡无奇啦～想知道小编是怎样炼成的吗？现在就把独门秘籍传授给你，论怎样简便高效地打造出别样气氛的屋子呢？闪开！上灯！,
	title : 装饰灯登场，气氛turn up！,
	updated_at : 1445937578,
	short_title : 最美装饰灯,
	liked : 0,
	likes_count : 532,
	status : 0
 */
/**
 * cover_image_url
 */
@property (nonatomic, copy) NSString *cover_image_url;
/**
 *  itemID
 */
@property (nonatomic, assign) NSInteger itemID;
/**
 * published_at
 */
@property (nonatomic, copy) NSString *published_at;

/**
 * content_url
 */
@property (nonatomic, copy) NSString *content_url;
/**
 * url
 */
@property (nonatomic, copy) NSString *url;
/**
 * type
 */
@property (nonatomic, copy) NSString *type;
/**
 * share_msg
 */
@property (nonatomic, copy) NSString *share_msg;
/**
 * title
 */
@property (nonatomic, copy) NSString *title;
/**
 * short_title
 */
@property (nonatomic, copy) NSString *short_title;
/**
 * likes_count
 */
@property (nonatomic, assign) NSInteger likes_count;
/**
 *  status
 */
@property (nonatomic, assign) NSInteger status;

@end

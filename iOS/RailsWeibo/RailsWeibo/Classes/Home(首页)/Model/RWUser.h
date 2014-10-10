//
//  RWUser.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-5.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  微博用户，发微博的作者

#import <Foundation/Foundation.h>

@interface RWUser : NSObject
/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  是否为vip
 */
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end

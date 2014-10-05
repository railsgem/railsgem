//
//  RWStatus.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-5.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  微博模型(一个IWStatus对象就代表一条微博)

#import <Foundation/Foundation.h>
@class RWUser;

@interface RWStatus : NSObject
/**
 *  微博的内容（文字）
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的作者
 */
@property (nonatomic, strong) RWUser *user;


@end

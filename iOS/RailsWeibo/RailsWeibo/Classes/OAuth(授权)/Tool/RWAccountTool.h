//
//  RWAccountTool.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-4.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  账号管理工具类

#import <Foundation/Foundation.h>

@class RWAccount;

@interface RWAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void) saveAccount:(RWAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (RWAccount *)account;
@end

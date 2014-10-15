//
//  RWUserTool.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  用户	处理类（工具类）

#import <Foundation/Foundation.h>
#import "RWUserInfoParam.h"
#import "RWUserInfoResult.h"
#import "RWUserUnreadCountParam.h"
#import "RWUserUnreadCountResult.h"

@interface RWUserTool : NSObject


/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)userInfoWithParam:(RWUserInfoParam *)param success:(void (^)(RWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载用户的个人信息的未读数
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)userUnreadCountWithParam:(RWUserUnreadCountParam *)param success:(void (^)(RWUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end

//
//  RWStatusTool.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  业务处理类（工具类）

#import <Foundation/Foundation.h>
#import "RWHomeStatusesParam.h"
#import "RWHomeStatusesResult.h"
#import "RWSendStatusParam.h"
#import "RWSendStatusResult.h"


@interface RWStatusTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)homeStatusesWithParam:(RWHomeStatusesParam *)param success:(void (^)(RWHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一条微博
 */
+ (void)sendStatusWithParam:(RWSendStatusParam *)param success:(void (^)(RWSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end

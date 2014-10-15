//
//  RWStatusTool.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  业务处理类（工具类）

#import <Foundation/Foundation.h>
@class RWHomeStatusesParam;

@interface RWStatusTool : NSObject

+(void)homeStatusesWithParam:(RWHomeStatusesParam *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end

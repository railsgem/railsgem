//
//  RWStatusTool.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWStatusTool.h"
#import "RWHttpTool.h"
#import "MJExtension.h"

@implementation RWStatusTool

+(void)homeStatusesWithParam:(RWHomeStatusesParam *)param success:(void (^)(RWHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [RWHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            RWHomeStatusesResult *result = [RWHomeStatusesResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)sendStatusWithParam:(RWSendStatusParam *)param success:(void (^)(RWSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [RWHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            RWSendStatusResult *result = [RWSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end


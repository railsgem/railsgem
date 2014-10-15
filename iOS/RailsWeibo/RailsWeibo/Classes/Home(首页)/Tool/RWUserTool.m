//
//  RWUserTool.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWUserTool.h"
#import "RWHttpTool.h"
#import "MJExtension.h"

@implementation RWUserTool

+(void)userInfoWithParam:(RWUserInfoParam *)param success:(void (^)(RWUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [RWHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            RWUserInfoResult *result = [RWUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
@end

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
#import "RWHomeStatusesParam.h"

@implementation RWStatusTool

+(void)homeStatusesWithParam:(RWHomeStatusesParam *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{    
    [RWHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end


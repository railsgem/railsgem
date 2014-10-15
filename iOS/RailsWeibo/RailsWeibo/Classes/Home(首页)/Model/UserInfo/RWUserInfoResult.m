//
//  RWUserInfoResult.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWUserInfoResult.h"
#import "MJExtension.h"
#import "RWStatus.h"


@implementation RWUserInfoResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [RWStatus class]};
}

@end

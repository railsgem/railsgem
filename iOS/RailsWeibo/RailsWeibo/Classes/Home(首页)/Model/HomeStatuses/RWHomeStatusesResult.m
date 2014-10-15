//
//  RWHomeStatusesResult.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWHomeStatusesResult.h"
#import "MJExtension.h"
#import "RWStatus.h"


@implementation RWHomeStatusesResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [RWStatus class]};
}

@end

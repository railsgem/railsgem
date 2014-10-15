//
//  RWBaseParam.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWBaseParam.h"
#import "RWAccount.h"
#import "RWAccountTool.h"

@implementation RWBaseParam

- (id)init
{
    if (self = [super init]) {
        self.access_token = [RWAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

@end

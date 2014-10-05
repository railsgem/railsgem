//
//  RWStatus.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-5.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  微博模型 一个对象代表一条微博

#import "RWStatus.h"
#import "RWUser.h"

@implementation RWStatus
+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.text = dict[@"text"];
        self.source = dict[@"source"];
        self.reposts_count = dict[@"reposts_count"];
        self.comments_count = dict[@"comments_count"];
        self.user = [RWUser userWithDict:dict[@"user"]];
    }
    return self;
}

@end

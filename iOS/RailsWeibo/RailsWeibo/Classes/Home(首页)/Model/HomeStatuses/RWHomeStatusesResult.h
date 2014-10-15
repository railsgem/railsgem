//
//  RWHomeStatusesResult.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  封装加载首页数据的返回结果

#import <Foundation/Foundation.h>

@interface RWHomeStatusesResult : NSObject

/**
 *  statuses数组里面放的都是IWStatus模型
 */
@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;

@end

//
//  NSDate+CY.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-10.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CY)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end

//
//  RWUserUnreadCountParam.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWBaseParam.h"

@interface RWUserUnreadCountParam : RWBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;
@end

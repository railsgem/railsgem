//
//  RWBaseParam.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-15.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;
@end

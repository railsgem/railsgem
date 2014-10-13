//
//  RWAccount.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-4.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWAccount : NSObject <NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) NSDate *expiresTime; // 账号当时的保存时间
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end

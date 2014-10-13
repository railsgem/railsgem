//
//  RWAccount.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-4.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  账号模型

#import "RWAccount.h"

@implementation RWAccount
+(instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

/**
 *  从文件中解析对象的时候调用
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.name forKey:@"name"];
    [enCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [enCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [enCoder encodeInt64:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
}

@end

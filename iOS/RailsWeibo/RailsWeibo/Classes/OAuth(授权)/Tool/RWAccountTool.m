//
//  RWAccountTool.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-4.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWAccount.h"
#import "RWAccountTool.h"

#define RWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation RWAccountTool

+ (void)saveAccount:(RWAccount *)account
{
    // 计算账号过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:RWAccountFile];
}

+(RWAccount *)account
{
    // 取出账号
    RWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:RWAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {//还没有过期
        return account;
    } else { // 过期
        return nil;
    }
    
    return account;
}
@end

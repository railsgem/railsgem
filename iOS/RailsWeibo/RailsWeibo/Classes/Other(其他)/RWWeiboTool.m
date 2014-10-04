//
//  RWWeiboTool.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-4.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//  

#import "RWWeiboTool.h"
#import "RWTabBarViewController.h"
#import "RWNewfeatureViewController.h"

@implementation RWWeiboTool
+ (void)chooseRootController
{
    
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前的软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[RWTabBarViewController alloc] init];
        
    } else {
        // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[RWNewfeatureViewController alloc] init];
        
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    

}
@end

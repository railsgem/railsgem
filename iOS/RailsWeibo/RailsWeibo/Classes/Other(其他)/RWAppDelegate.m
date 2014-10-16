//
//  RWAppDelegate.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-25.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWAppDelegate.h"
#import "RWOAuthViewController.h"
#import "RWWeiboTool.h"
#import "RWAccount.h"
#import "RWAccountTool.h"
#import "SDWebImageManager.h"

@implementation RWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    // 1.先判断有无存储账号信息
    RWAccount *account = [RWAccountTool account];
    
    if (account) { // 之前登录成功
        // 之前登录成功
        [RWWeiboTool chooseRootController];
    } else { // 之前没有登陆成功
        self.window.rootViewController = [[RWOAuthViewController alloc] init];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 在后台开启任务让程序持续保持运行（能保持运行的时间是不确定）
    [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    
    // 定时提醒，定时弹框
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end

//
//  CPTabBarController.m
//  Lottery
//
//  Created by Rails Chen on 15/2/5.
//  Copyright (c) 2015年 Railsgem. All rights reserved.
//

#import "CPTabBarController.h"
#import "CPTabBar.h"

@interface CPTabBarController ()

@end

@implementation CPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RWLog(@"%@", self.tabBar.subviews);
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1.删除默认的tab按钮
        [self.tabBar removeFromSuperview];
//        for (UIControl *btn in self.tabBar.subviews) {
//            //        RWLog(@"%@", btn.superclass);
//            [btn removeFromSuperview];
//        }
        
        //设置tabBar的背景
        CPTabBar *myTabBar = [[CPTabBar alloc] init];
        myTabBar.frame = self.tabBar.frame;
        [self.view addSubview:myTabBar];
//        self.tabBar.backgroundImage = [UIImage imageNamed:@"TabBarBack"];
    });
    
    
}

@end

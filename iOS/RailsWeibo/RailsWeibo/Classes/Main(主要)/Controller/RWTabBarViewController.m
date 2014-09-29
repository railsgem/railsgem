//
//  RWTabBarViewController.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-25.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWTabBarViewController.h"
#import "RWMeViewController.h"
#import "RWMessageViewController.h"
#import "RWHomeViewController.h"
#import "RWDiscoverViewController.h"
#import "UIImage+CY.h"
#import "RWTabBar.h"

@interface RWTabBarViewController ()<RWTabBarDelegate>
/**
 *  自定义的Tabbar
 */
@property (nonatomic,weak)RWTabBar *customTabBar;
@end

@implementation RWTabBarViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化Tabbar
    [self setupTabbar];
    
    //初始化所有的子控制器
    [self setupAllChildViewControllers];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSLog(@"%@", self.tabBar.subviews);
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
//            NSLog(@"%@", child.superclass);
            
        }
    }
    
}

/**
 *  初始化Tabbar
 */

-(void)setupTabbar
{
    //自定义Tabbar
    RWTabBar *customTabBar = [[RWTabBar alloc] init];
    //设置背景
//    customTabBar.backgroundColor = [UIColor redColor];
    //设置边框才能出现
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听Tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
-(void)tabBar:(RWTabBar *)tabBar didSelectedButtonForm:(int)from to:(int)to
{
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */

-(void)setupAllChildViewControllers
{
    //首页
    RWHomeViewController *home = [[RWHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    //消息
    RWMessageViewController *message = [[RWMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    //广场
    RWDiscoverViewController *discover = [[RWDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    //我
    RWMeViewController *me = [[RWMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
}

/**
 *  初始化一个子控件
 *
 *  @param childVc           需要初始化的子控件
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */

-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    //包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    //添加Tabbar内部按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}

@end

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

@interface RWTabBarViewController ()

@end

@implementation RWTabBarViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化所有的子控制器
    
    [self setupAllChildViewControllers];
    

}
/**
 *  初始化所有的子控制器
 */

-(void)setupAllChildViewControllers
{
    //首页
    RWHomeViewController *home = [[RWHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home_os7" selectedImageName:@"tabbar_home_selected_os7"];
    
    //消息
    RWMessageViewController *message = [[RWMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center_os7" selectedImageName:@"tabbar_message_center_selected_os7"];
    
    //广场
    RWDiscoverViewController *discover = [[RWDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover_os7" selectedImageName:@"tabbar_discover_selected_os7"];
    
    //我
    RWMeViewController *me = [[RWMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile_os7" selectedImageName:@"ttabbar_profile_selected_os7"];
    
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
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    
}

@end

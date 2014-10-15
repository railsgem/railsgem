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
#import "RWNavigationController.h"
#import "UIImage+CY.h"
#import "RWTabBar.h"
#import "RWComposeViewController.h"
#import "RWUserTool.h"
#import "RWAccount.h"
#import "RWAccountTool.h"


@interface RWTabBarViewController ()<RWTabBarDelegate>
/**
 *  自定义的Tabbar
 */
@property (nonatomic,weak)RWTabBar *customTabBar;
@property (nonatomic, strong) RWHomeViewController *home;
@property (nonatomic, strong) RWMessageViewController *message;
// 3.广场
@property (nonatomic, strong) RWDiscoverViewController *discover;
// 4.我
@property (nonatomic, strong) RWMeViewController *me;
@end


@implementation RWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化Tabbar
    [self setupTabbar];
    
    //初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    // 定时检查未读数
//    [self checkUnreadCount];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];

}

/**
 *  定时检查未读数
 */
-(void)checkUnreadCount
{    
    // 1.请求参数
    RWUserUnreadCountParam *param = [[RWUserUnreadCountParam alloc] init];
    param.uid = @([RWAccountTool account].uid);
    
    // 2.发送请求
    [RWUserTool userUnreadCountWithParam:param success:^(RWUserUnreadCountResult *result) {
        
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
    } failure:^(NSError *error) {
        
    }];
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

#pragma mark - tabbar的代理方法

/**
 *  监听Tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
-(void)tabBar:(RWTabBar *)tabBar didSelectedButtonForm:(int)from to:(int)to
{
    self.selectedIndex = to;
    
    if (to == 0) {
        [self.home refresh];
    }
}

/**
 *  监听加号按钮点击
 */
-(void)tabBarDidClickedPlusButton:(RWTabBar *)tabBar
{
    RWComposeViewController *compose = [[RWComposeViewController alloc] init];
    RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
    
}

/**
 *  初始化所有的子控制器
 */

-(void)setupAllChildViewControllers
{
    //首页
    RWHomeViewController *home = [[RWHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    //消息
    RWMessageViewController *message = [[RWMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    //广场
    RWDiscoverViewController *discover = [[RWDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    //我
    RWMeViewController *me = [[RWMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.me = me;
    
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
    RWNavigationController *nav = [[RWNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    //添加Tabbar内部按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}

@end

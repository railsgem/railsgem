//
//  RWTabBar.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-26.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWTabBar;

@protocol RWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(RWTabBar *)tabBar didSelectedButtonForm:(int)from to:(int)to;
- (void)tabBarDidClickedPlusButton:(RWTabBar *)tabBar;

@end

@interface RWTabBar : UIView

-(void)addTabBarButtonWithItem:(UITabBarItem *)item;
 
@property (nonatomic,weak)id<RWTabBarDelegate> delegate;

@end

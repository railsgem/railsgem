//
//  RWTabBar.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-26.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWTabBar.h"
#import "RWTabBarButton.h"

@interface RWTabBar()
@property (nonatomic,strong) NSMutableArray *tabBarButtons;
@property (nonatomic,weak) RWTabBarButton *selectedButton;
@property (nonatomic,weak) UIButton *plusButton;
@end

@implementation RWTabBar

-(NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        //添加一个加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusButton = plusButton;
        
    }
    //
    return self;
}

-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    RWTabBarButton *button = [[RWTabBarButton alloc]init];
    [self addSubview:button];
    
    //添加按钮到数组中去
    [self.tabBarButtons addObject:button];
    
    //2.设置数据
    button.item = item;
        
    //3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
-(void)buttonClick:(RWTabBarButton *)button
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonForm:to:)]) {
        [self.delegate tabBar:self  didSelectedButtonForm:self.selectedButton.tag to:button.tag];
    }
    
    //设定按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w * 0.5 , h * 0.5);
    
    
    //按钮frame的数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0 ; index < self.tabBarButtons.count; index++) {
        //取出按钮
        RWTabBarButton *button = self.tabBarButtons[index];
        //设置按钮的frame
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //绑定tag
        button.tag = index;
    }
}
@end

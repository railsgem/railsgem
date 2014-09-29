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

@property (nonatomic,weak)RWTabBarButton *selectedButton;

@end

@implementation RWTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
    }
    return self;
}

-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    RWTabBarButton *button = [[RWTabBarButton alloc]init];
    [self addSubview:button];
    
    //2.设置数据
    button.item = item;
        
    //3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个按钮
    if (self.subviews.count == 1) {
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
    
    CGFloat buttonY = 0;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    for (int index = 0 ; index < self.subviews.count; index++) {
        //取出按钮
        RWTabBarButton *button = self.subviews[index];
        //设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //绑定tag
        button.tag = index;
    }
}
@end

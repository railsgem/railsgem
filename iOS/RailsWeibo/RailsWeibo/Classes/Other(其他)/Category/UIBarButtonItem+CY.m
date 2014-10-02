//
//  UIBarButtonItem+CY.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-2.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "UIBarButtonItem+CY.h"

@implementation UIBarButtonItem (CY)


/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 *
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end

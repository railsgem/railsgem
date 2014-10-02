//
//  UIBarButtonItem+CY.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-2.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CY)

/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 *
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end

//
//  RWTabBarButton.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-28.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

/**
 *  图标的比例
 */
#define RWTabBarButtonImageRatio 0.6

//按钮默认文字颜色
#define RWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])

//按钮默认选中文字颜色
#define RWTabBarButtonTitleSelectedColor (iOS7 ? RWColor(234, 103, 7)  : RWColor(248, 139, 0) )

#import "RWTabBarButton.h"

@implementation RWTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [self setTitleColor:RWTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:RWTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * RWTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect )titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.width * RWTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY -25;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}
@end

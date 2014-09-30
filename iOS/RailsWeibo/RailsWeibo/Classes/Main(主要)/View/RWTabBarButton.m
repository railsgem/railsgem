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
#define RWTabBarButtonImageRatio 0.7

//按钮默认文字颜色
#define RWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])

//按钮默认选中文字颜色
#define RWTabBarButtonTitleSelectedColor (iOS7 ? RWColor(234, 103, 7)  : RWColor(248, 139, 0) )

#import "RWTabBarButton.h"
#import "RWBadgeButton.h"

@interface RWTabBarButton()
/**
 *  提醒数字
 */
@property (nonatomic,weak) RWBadgeButton *badgeButton;


@end

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
        //添加一个提醒数字的按钮
        RWBadgeButton *badgeButton = [[RWBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
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
    
    //KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}

-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"----%@的%@属性被改变", object , keyPath);
    
    //设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    //设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    //设置提醒数字的位置
    CGFloat badgeY = 0;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
    
}


@end

//
//  RWTitleButton.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-2.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWTitleButton.h"
#define RWTitleButtonImageW 20

@implementation RWTitleButton

+(instancetype)titleButton
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 高亮的时候不要自动调整图标
        self.adjustsImageWhenDisabled = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight ;
        // 背景
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];

    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageY = 0;
    CGFloat imageW = RWTitleButtonImageW ;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageX = 0;
    CGFloat imageW = contentRect.size.width - RWTitleButtonImageW ;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW , imageH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    // 根据title计算自己的宽度
    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
    
    CGRect frame = self.frame;
    frame.size.width = titleW + RWTitleButtonImageW + 5;
    self.frame = frame;
    
    [super setTitle:title forState:state];
    
}

@end

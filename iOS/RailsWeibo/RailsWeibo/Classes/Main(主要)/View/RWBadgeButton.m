//
//  RWBadgeButton.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-29.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWBadgeButton.h"

@implementation RWBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11.0f];

    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
#warning copy
    _badgeValue = [badgeValue copy];
    //设置提醒数字
    if (badgeValue && [badgeValue intValue] != 0) {
        self.hidden = NO;
        //设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        
        //设置frame
        CGRect frame = self.frame;
//        CGFloat badgeY = 0;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            //文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        
    } else {
        self.hidden = YES;
    }
}

@end

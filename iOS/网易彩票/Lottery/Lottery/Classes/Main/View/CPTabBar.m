//
//  CPTabBar.m
//  Lottery
//
//  Created by Rails Chen on 15/2/5.
//  Copyright (c) 2015年 Railsgem. All rights reserved.
//

#import "CPTabBar.h"

@implementation CPTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBarBack"]];
        self.backgroundImage = [UIImage imageNamed:@"TabBarBack"];
    }
    return self;
}

@end

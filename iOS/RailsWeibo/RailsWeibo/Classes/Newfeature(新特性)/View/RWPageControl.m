//
//  RWPageControl.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-3.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWPageControl.h"

@implementation RWPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
}

@end

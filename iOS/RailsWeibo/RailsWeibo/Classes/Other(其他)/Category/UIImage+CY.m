//
//  UIImage+CY.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-26.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "UIImage+CY.h"

@implementation UIImage (CY)

+(UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    
    //非iOS7
    return [UIImage imageNamed:name];
    
}

@end

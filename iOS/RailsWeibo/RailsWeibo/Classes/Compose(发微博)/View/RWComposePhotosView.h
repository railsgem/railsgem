//
//  RWComposePhotosView.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-14.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWComposePhotosView : UIView
/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 */
- (NSArray *)totalImages;


@end

//
//  RWPhotosView.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-10.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWPhotosView : UIView

/**
 *  需要展示的图片(数组里面装的都是RWPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;

@end

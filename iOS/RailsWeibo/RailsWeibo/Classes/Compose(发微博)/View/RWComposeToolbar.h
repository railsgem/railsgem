//
//  RWComposeToolbar.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-14.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWComposeToolbar;

typedef enum {
    RWComposeToolbarButtonTypeCamera,
    RWComposeToolbarButtonTypePicture,
    RWComposeToolbarButtonTypeMention,
    RWComposeToolbarButtonTypeTrend,
    RWComposeToolbarButtonTypeEmotion
} RWComposeToolbarButtonType;

@protocol RWComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(RWComposeToolbar *)toolbar didClickedButton:(RWComposeToolbarButtonType)buttonType;
@end

@interface RWComposeToolbar : UIView
@property (weak, nonatomic) id<RWComposeToolbarDelegate> delegate;
@end

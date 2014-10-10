//
//  RWStatusFrame.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-9.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 昵称的字体 */
#define RWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define RWRetweetStatusNameFont RWStatusNameFont

/** 时间的字体 */
#define RWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define RWStatusSourceFont RWStatusTimeFont

/** 正文的字体 */
#define RWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define RWRetweetStatusContentFont RWStatusContentFont

/** 表格的边框宽度 */
#define RWStatusTableBorder 5

/** cell的边框宽度 */
#define RWStatusCellBorder 10

@class RWStatus;
@interface RWStatusFrame : NSObject


@property (nonatomic, strong) RWStatus *status;

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end

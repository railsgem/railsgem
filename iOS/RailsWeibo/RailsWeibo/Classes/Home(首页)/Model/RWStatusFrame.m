//
//  RWStatusFrame.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-9.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWStatusFrame.h"
#import "RWStatus.h"
#import "RWUser.h"

/** cell的边框宽度 */
#define RWStatusCellBorder 5

@implementation RWStatusFrame

/**
 *  获得微博模型数据之后, 根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(RWStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = RWStatusCellBorder;
    CGFloat iconViewY = RWStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + RWStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:RWStatusNameFont];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.isVip) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + RWStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + RWStatusCellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithFont:RWStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + RWStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:RWStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + RWStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * RWStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:RWStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 计算topViewF
    CGFloat topViewH = CGRectGetMaxY(_contentLabelF) + RWStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 计算cell的高度
    _cellHeight = topViewH;
}
@end

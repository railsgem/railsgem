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
#import "RWPhotosView.h"

@implementation RWStatusFrame

/**
 *  获得微博模型数据之后, 根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(RWStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * RWStatusTableBorder;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
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
    if (status.user.mbtype > 2) {
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
    
    // 8.配图
    if (status.pic_urls.count) {
#warning 根据图片个数计算整个相册的尺寸
        CGSize photosViewSize = [RWPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + RWStatusCellBorder;
        _photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
    }
    
    // 9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + RWStatusCellBorder * 0.5;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = RWStatusCellBorder;
        CGFloat retweetNameLabelY = RWStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:RWRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + RWStatusCellBorder * 0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * RWStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:RWRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.pic_urls.count) {
#warning 根据图片个数计算整个相册的尺寸
            CGSize retweetPhotosViewSize = [RWPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + RWStatusCellBorder;
            _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += RWStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else { // 没有转发微博
        if (status.pic_urls.count) { // 有图
            topViewH = CGRectGetMaxY(_photosViewF);
        } else { // 无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += RWStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    
    // 13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + RWStatusTableBorder;
}
@end

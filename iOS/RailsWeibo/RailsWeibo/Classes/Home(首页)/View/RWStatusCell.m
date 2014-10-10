//
//  RWStatusCell.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-8.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWStatusCell.h"
#import "RWStatus.h"
#import "RWStatusFrame.h"
#import "RWUser.h"
#import "UIImageView+WebCache.h"
#import "RWStatusTopView.h"
#import "RWStatusToolbar.h"

@interface RWStatusCell()
/** 顶部的view */
@property (nonatomic, weak) RWStatusTopView *topView;
/** 微博的工具条 */
@property (nonatomic, weak) RWStatusToolbar *statusToolbar;

@end

@implementation RWStatusCell


#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    RWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[RWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加顶部的view
        [self setupTopView];
        
        // 2.添加微博的工具条
        [self setupStatusToolbar];
    }
    return self;
}

/**
 *  添加顶部的view
 */
- (void)setupTopView
{
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];

    /** 1.顶部的view */
    RWStatusTopView *topView = [[RWStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolbar
{
    /** 微博的工具条 */
    RWStatusToolbar *statusToolbar = [[RWStatusToolbar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += RWStatusTableBorder;
    frame.origin.x = RWStatusTableBorder;
    frame.size.width -= 2 * RWStatusTableBorder;
    frame.size.height -= RWStatusTableBorder;
    [super setFrame:frame];
}

#pragma mark - 数据的设置
/**
 *  传递模型数据
 */
- (void)setStatusFrame:(RWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.设置顶部view的数据
    [self setupTopViewData];
    
    // 2.设置微博工具条的数据
    [self setupStatusToolbarData];
}

/**
 *  设置顶部view的数据
 */
- (void)setupTopViewData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.传递模型数据
    self.topView.statusFrame = self.statusFrame;
}
/**
 *  设置微博工具条的数据
 */
- (void)setupStatusToolbarData
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}

@end

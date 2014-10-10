//
//  RWStatusCell.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-8.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWStatusFrame;
@interface RWStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) RWStatusFrame *statusFrame;

@end

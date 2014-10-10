//
//  RWHomeViewController.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-25.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWHomeViewController.h"
#import "RWBadgeButton.h"
#import "UIBarButtonItem+CY.h"
#import "RWTitleButton.h"
#import "AFNetworking.h"
#import "RWAccountTool.h"
#import "RWAccount.h"
#import "UIImageView+WebCache.h"
#import "RWUser.h"
#import "RWStatus.h"
#import "MJExtension.h"
#import "RWStatusFrame.h"
#import "RWStatusCell.h"

#define RWTitleButtonDownTag 0
#define RWTitleButtonUpTag -1

@interface RWHomeViewController ()
@property (nonatomic,strong) NSArray *statusFrames;
@end

@implementation RWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置导航栏内容
    [self setupNavBar];
    
    // 2.加载微博数据
    [self setupStatusData];
}

/**
 *  加载微博数据
 */
-(void)setupStatusData
{
    
    // AFNetworking/AFN
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [RWAccountTool account].access_token;
    
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // 取出所有微博数据(每一条微博都是一个字典)
//        NSArray *dictArray = responseObject[@"statuses"];
//        
////        // 将字典数据转为模型数据
////        NSMutableArray *statusArray = [NSMutableArray array];
////        for (NSDictionary *dict in dictArray) {
////            // 创建模型
////            RWStatus *status = [RWStatus objectWithKeyValues:dict];
////            
////            // 添加模型
////            [statusArray addObject:status];
////        }
//        
//        self.statuses = [RWStatus objectArrayWithKeyValuesArray:dictArray];
//
        // 将字典数组转为模型数组(里面放的就是RWStatus模型)
        NSArray *statusArray = [RWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (RWStatus *status in statusArray) {
            RWStatusFrame *statusFrame = [[RWStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 赋值
        self.statusFrames = statusFrameArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/**
 *  设置导航栏内容
 */
- (void)setupNavBar
{// 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    RWTitleButton *titleButton = [RWTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = RWColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, RWStatusTableBorder, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)titleClick:(RWTitleButton *)titleButton
{
    if (titleButton.tag == RWTitleButtonUpTag) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = RWTitleButtonDownTag;
    } else {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = RWTitleButtonUpTag;
    }
}

- (void)findFriend
{
    RWLog(@"findFriend");
}

- (void)pop
{
    RWLog(@"pop");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.创建cell
    RWStatusCell *cell = [RWStatusCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end

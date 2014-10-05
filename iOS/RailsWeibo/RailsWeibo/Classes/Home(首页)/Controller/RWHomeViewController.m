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

#define RWTitleButtonDownTag 0
#define RWTitleButtonUpTag -1

@interface RWHomeViewController ()
@property (nonatomic,strong) NSArray *statuses;
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
        // 取出所有微博数据(每一条微博都是一个字典)
        NSArray *dictArray = responseObject[@"statuses"];
        
//        // 将字典数据转为模型数据
//        NSMutableArray *statusArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            // 创建模型
//            RWStatus *status = [RWStatus objectWithKeyValues:dict];
//            
//            // 添加模型
//            [statusArray addObject:status];
//        }
        
        self.statuses = [RWStatus objectArrayWithKeyValuesArray:dictArray];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/**
 *  设置导航栏内容
 */
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    RWTitleButton *titleButton = [RWTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"啊哈哈哈" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 40 );
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
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
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //设置cell的数据
    // 微博的文字内容
    RWStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    // 微博作者昵称
    RWUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 微博作者的头像
    [cell.imageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"hot_status"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

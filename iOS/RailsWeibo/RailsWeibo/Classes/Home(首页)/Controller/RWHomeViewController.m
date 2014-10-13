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
#import "MJRefresh.h"

#define RWTitleButtonDownTag 0
#define RWTitleButtonUpTag -1

@interface RWHomeViewController ()<MJRefreshBaseViewDelegate>
@property (nonatomic, weak) RWTitleButton *titleButton;
@property (nonatomic,strong) NSMutableArray *statusFrames;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@end

@implementation RWHomeViewController

-(NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 0.集成刷新控件
    [self setupRefreshView];
    
    // 1.设置导航栏内容
    [self setupNavBar];
    
    // 2.获得用户信息
    [self setupUserData];
    
}

- (void)setupUserData
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [RWAccountTool account].access_token;
    params[@"uid"] = @([RWAccountTool account].uid);
    
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 字典转模型
        RWUser *user = [RWUser objectWithKeyValues:responseObject];
        // 设置标题文字
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 保存昵称
        RWAccount *account = [RWAccountTool account];
        account.name = user.name;
        [RWAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

/**
 *  集成刷新控件
 */
-(void)setupRefreshView
{
    // 1.下拉刷新
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态（不会触发监听方法）
    [header beginRefreshing];
    self.header = header;
    
    
    // 2.上拉刷新（上拉加载更多数据）
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self loadMoreData];
    } else {
        [self loadNewData];
    }
}

/**
 *  发送请求加载更多的微博数据
 */
-(void)loadMoreData
{
    
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [RWAccountTool account].access_token;
    params[@"count"] = @10;
    
    if (self.statusFrames.count) {
        RWStatusFrame *statusFrame = self.statusFrames[0];
        // 加载ID比since_id大的微博
        long long maxId = [statusFrame.status.idstr longLongValue] -1 ;
        params[@"max_id"] = @(maxId);
    }
    
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        
        // 将最新的数据追加到旧数据的后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
        
    }];

}

-(void)loadNewData
{
    
    // 刷新数据（向新浪获取更新的数据）
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [RWAccountTool account].access_token;
    params[@"count"] = @10;
    
    if (self.statusFrames.count) {
        RWStatusFrame *statusFrame = self.statusFrames[0];
        // 加载ID比since_id大的微博
        params[@"since_id"] = statusFrame.status.idstr;
    }
    
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        
        // 将最新的数据追加到旧数据的最前面
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
        // 显示最新的微博数量（提醒）
        [self showNewStatusCount:statusFrameArray.count];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
    }];

}

- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    // 刷新数据（向新浪获取更新的数据）
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [RWAccountTool account].access_token;
    params[@"count"] = @10;
    
    if (self.statusFrames.count) {
        RWStatusFrame *statusFrame = self.statusFrames[0];
        // 加载ID比since_id大的微博
        params[@"since_id"] = statusFrame.status.idstr;
    }
    
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        
        // 将最新的数据追加到旧数据的最前面
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
        
        // 显示最新的微博数量（提醒）
        [self showNewStatusCount:statusFrameArray.count];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
        
    }];
    
}

/**
 *  显示最新的微博数量（提醒）
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusCount:(int)count
{
    // 1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 把btn从内存中移除
            [btn removeFromSuperview];
        }];
        
    }];
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
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    RWTitleButton *titleButton = [RWTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    // 文字
    if ([RWAccountTool account].name) {
        [titleButton setTitle:[RWAccountTool account].name forState:UIControlStateNormal];
    } else {
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    
    // 位置和尺寸
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
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
